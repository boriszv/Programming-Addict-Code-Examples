import 'package:flutter/material.dart';

class RestaurantCard extends StatelessWidget {

  final String imageUrl;
  final String title;
  final String location;
  final double averageRating;

  final radius = 10.0;

  RestaurantCard({
    this.imageUrl,
    this.title,
    this.location,
    this.averageRating,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      shadowColor: Colors.grey.shade100,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(radius), topRight: Radius.circular(radius),),
            child: Image.network(
              imageUrl,
              height: 120,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  transform: Matrix4.translationValues(-2, 0, 0),
                  child: Row(
                    children: [
                      Icon(Icons.location_on, size: 13, color: Colors.grey),
                      const SizedBox(width: 3),
                      Text(location, style: TextStyle(fontSize: 12, color: Colors.grey)),
                    ],
                  ),
                ),
                const SizedBox(height: 5),
                Text(title, style: Theme.of(context).textTheme.headline6.apply(fontSizeDelta: -2)),
                const SizedBox(height: 5),

                Container(
                  transform: Matrix4.translationValues(-2, 0, 0),
                  child: Row(
                    children: [
                      Icon(Icons.star, color: Colors.yellow, size: 16),
                      const SizedBox(width: 3),
                      Text(averageRating.toStringAsPrecision(2), style: TextStyle(fontSize: 13),),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
