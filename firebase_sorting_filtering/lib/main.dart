import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/intl.dart';

void main() async {
  runApp(const App());
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late Future<FirebaseApp> _firebase;

  @override
  void initState() {
    _firebase = Firebase.initializeApp();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FirebaseApp>(
      future: _firebase,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return Container();
        }
        return MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const Home(),
        );
      },
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
//
  String? sortBy;

  var descending = false;

  int? min;
  int? max;

  late var queryFuture = _getQuery() //
      .get();

  void _sortChanged(String? value) {
    setState(() {
      if (sortBy != 'viewCount' && (min != null || max != null)) {
        sortBy = null;
      } else {
        sortBy = value;
      }

      queryFuture = _getQuery().get();
    });
  }

  void _descendingChanged(bool? value) {
    setState(() {
      descending = value ?? false;
      queryFuture = _getQuery().get();
    });
  }

  void _minChanged(String text) {
    setState(() {
      min = int.tryParse(text);
      queryFuture = _getQuery().get();
    });
  }

  void _maxChanged(String text) {
    setState(() {
      max = int.tryParse(text);
      queryFuture = _getQuery().get();
    });
  }

  Query<Map<String, dynamic>> _getQuery() {
    var query = FirebaseFirestore.instance
        .collection('videos') //
        .limit(10);

    if (sortBy != null) {
      query = query.orderBy(sortBy!, descending: descending);
    }

    if (min != null) {
      query = query.where('viewCount', isGreaterThanOrEqualTo: min);
    }

    if (max != null) {
      query = query.where('viewCount', isLessThanOrEqualTo: max);
    }

    return query;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _SortBy(
                sortBy: sortBy,
                onChanged: _sortChanged,
              ),
              Checkbox(
                value: descending,
                onChanged: _descendingChanged,
              ),
              const Text('Descending?'),
            ],
          ),
          if (sortBy == 'viewCount' || sortBy == null)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(width: 10),
                Flexible(
                  child: TextField(
                    onChanged: _minChanged,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Min views',
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Flexible(
                  child: TextField(
                    onChanged: _maxChanged,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Max views',
                    ),
                  ),
                ),
                const SizedBox(width: 10),
              ],
            ),
          const SizedBox(height: 20),
          Expanded(
            child: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
              future: queryFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return const Center(child: CircularProgressIndicator());
                }

                return ListView.separated(
                  itemBuilder: (context, index) {
                    final item = snapshot.data?.docs[index].data();
                    return _Video(item: item);
                  },
                  itemCount: snapshot.data?.docs.length ?? 0,
                  separatorBuilder: (context, index) => Divider(color: Colors.grey.shade700),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _Video extends StatelessWidget {
  _Video({
    Key? key,
    required this.item,
  }) : super(key: key);

  final decimal = NumberFormat.decimalPattern();

  final Map<String, dynamic>? item;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(item?['thumbnail']),
      title: Text(item?['title']),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 4),
          Text("${decimal.format(item?['viewCount'])} views · ${decimal.format(item?['likeCount'])} likes"),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(Icons.date_range, color: Colors.grey, size: 15),
              const SizedBox(width: 5),
              Text(
                DateFormat(DateFormat.YEAR_NUM_MONTH_WEEKDAY_DAY) //
                    .format(DateTime.parse(item?['publishedAt'])),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class _SortBy extends StatelessWidget {
  final String? sortBy;
  final Function(String?) onChanged;

  const _SortBy({
    Key? key,
    required this.sortBy,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: sortBy,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      underline: Container(height: 2),
      hint: const Text('Sort by'),
      onChanged: onChanged,
      items: <String>['title', 'viewCount', 'likeCount', 'thumbnail', 'publishedAt']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
