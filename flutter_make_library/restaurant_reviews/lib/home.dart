import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_reviews/widgets/app_toolbar.dart';
import 'package:restaurant_reviews/widgets/filter.dart';
import 'package:restaurant_reviews/widgets/restaurant_card.dart';

import 'models/restaurant.dart';

class Home extends StatefulWidget {

  const Home();

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final firestore = FirebaseFirestore.instance;

  var restaurants = <Restaurant>[];
  QueryDocumentSnapshot lastDocument;

  FilterResult filter;

  var isLoading = false;
  var isLoadingMore = false;
  var loadedAll = false;

  @override
  void initState() {
    _fetchRestaurants();
    super.initState();
  }

  Query _buildQuery({QueryDocumentSnapshot startAfter}) {
    Query query = firestore.collection('restaurants');

    if (filter?.minRating != null) {
      query = query.where('averageRating', isGreaterThanOrEqualTo: filter.minRating);
    }

    if (filter?.maxRating != null) {
      query = query.where('averageRating', isLessThanOrEqualTo: filter.maxRating);
    }

    if (filter?.minRating != null || filter?.maxRating != null) {
      query = query.orderBy('averageRating');

    } else if (filter?.sortBy != null) {
      query = query.orderBy(filter.sortBy, descending: filter.desc ?? false);
    }

    if (startAfter != null) {
      query = query.startAfterDocument(startAfter);
    }

    return query.limit(10);
  }

  Future _fetchRestaurants() async {
    setState(() { isLoading = true; });
    final result = await _buildQuery().get();
    setState(() {
      lastDocument = result.docs.last;
      restaurants = result.docs.map((e) => Restaurant.fromJson(e.data())).toList();
      isLoading = false;
    });
  }

  void _fetchMoreRestaurants() async {
    setState(() { isLoadingMore = true; });
    final result = await _buildQuery(startAfter: lastDocument).get();

    setState(() {
      if (result.docs.isNotEmpty) {
        lastDocument = result.docs.last;
        restaurants.addAll(result.docs.map((e) => Restaurant.fromJson(e.data())).toList());
      } else {
        loadedAll = true;
      }
      isLoadingMore = false;
    });
  }

  void openFilter() async {
    final result = await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (_) => Filter(
        minRating: filter?.minRating,
        maxRating: filter?.maxRating,
        sortBy: filter?.sortBy,
        desc: filter?.desc,
      ),
    );
    if (result == null) return;

    final parsedResult = result as FilterResult;
    setState(() {
      filter = parsedResult;
    });

    await _fetchRestaurants();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppToolbar(
        title: 'Home',
        actions: [
          TextButton(onPressed: openFilter, child: Icon(Icons.filter_list)),
        ],
      ),
      body: Builder(
        builder: (context) {
          if (isLoading) {
            return const Center(child: const CircularProgressIndicator());
          }

          return NotificationListener<ScrollNotification>(
            onNotification: (scrollInfo) {
              if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent && !isLoadingMore && !loadedAll) {
                _fetchMoreRestaurants();
              }
            },
            child: ListView.builder(
              itemBuilder: (context, index) {
                if (index == restaurants.length) {
                  return const Center(child: const CircularProgressIndicator());
                }

                final item = restaurants[index];
                return Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: RestaurantCard(
                    title: item.name,
                    averageRating: item.totalRatingScore / item.numberOfRatings,
                    location: item.place,
                    imageUrl: item.imageUrl,
                  ),
                );
              },
              itemCount: loadedAll ? restaurants.length : restaurants.length + 1,
            ),
          );
        },
      ),
    );
  }
}
