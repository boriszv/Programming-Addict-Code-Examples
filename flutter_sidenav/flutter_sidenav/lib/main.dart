import 'package:flutter/material.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Sidenav',
      theme: ThemeData(
        //
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int navIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sidenav app')),
      drawer: Sidenav(navIndex, (int index) {
        setState(() {
          navIndex = index;
        });
      }),

      body: Builder(
        builder: (context) {
          switch (navIndex) {
            case 0:
              return Center(child: Text('ALL INBOXES'));
            case 1:
              return Center(child: Text('PRIMARY'));
            case 2:
              return Center(child: Text('SOCIAL'));
            case 3:
              return Center(child: Text('PROMOTIONS'));
            case 4:
              return Center(child: Text('STARRED'));
            case 5:
              return Center(child: Text('SNOOZED'));
            case 6:
              return Center(child: Text('IMPROTANT'));
            case 7:
              return Center(child: Text('SENT'));
            default:
          }
        },
      ),
    );
  }
}

class Sidenav extends StatelessWidget {

  final Function setIndex;
  final int selectedIndex;

  Sidenav(this.selectedIndex, this.setIndex );

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text('Gmail', style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 21)),
          ),

          Divider(color: Colors.grey.shade400),

          _navItem(context, Icons.move_to_inbox, 'All inboxes',
            onTap: () { _navItemClicked(context, 0); },
            selected: selectedIndex == 0
          ),

          Divider(color: Colors.grey.shade400),

          _navItem(context, Icons.inbox, 'Primary',
            suffix: Text('28',style: TextStyle(fontWeight: FontWeight.w500),),
            onTap: () { _navItemClicked(context, 1); },
            selected: selectedIndex == 1
          ),

          _navItem(context, Icons.group, 'Social',
            suffix: Text('28',style: TextStyle(fontWeight: FontWeight.w500),),
            onTap: () { _navItemClicked(context, 2); },
            selected: selectedIndex == 2
          ),

          _navItem(context, Icons.local_offer, 'Promotions',
            suffix: Text('28',style: TextStyle(fontWeight: FontWeight.w500),),
            onTap: () { _navItemClicked(context, 3); },
            selected: selectedIndex == 3
          ),

          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text('ALL LABELS', style: TextStyle(fontWeight: FontWeight.w600, color: Colors.grey.shade700, letterSpacing: 1)),
          ),

          _navItem(context, Icons.star_border, 'Starred',
            onTap: () { _navItemClicked(context, 4); },
            selected: selectedIndex == 4
          ),
          
          _navItem(context, Icons.schedule, 'Snoozed',
            onTap: () { _navItemClicked(context, 5); },
            selected: selectedIndex == 5
          ),

          _navItem(context, Icons.label_important, 'Important',
            onTap: () { _navItemClicked(context, 6); },
            selected: selectedIndex == 6
          ),

          _navItem(context, Icons.send, 'Sent',
            onTap: () { _navItemClicked(context, 7); },
            selected: selectedIndex == 7
          ),
        ],
      ),
    );
  }

  _navItem(BuildContext context, IconData icon, String text, {Text suffix, Function onTap, bool selected = false}) => Container(
    color: selected ? Colors.grey.shade300 : Colors.transparent,
    child: ListTile(
      leading: Icon(icon, color: selected ? Theme.of(context).primaryColor : Colors.black),
      trailing: suffix,
      title: Text(text),
      selected: selected,
      onTap: onTap,
    ),
  );

  _navItemClicked(BuildContext context, int index) {
    setIndex(index);
    Navigator.of(context).pop();
  }
}
