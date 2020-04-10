import 'package:flutter/cupertino.dart';

class AppBarNetworkRoundedImage extends StatelessWidget {
  
  final String imageUrl;
  
  AppBarNetworkRoundedImage({@required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: NetworkImage(imageUrl)
          )
        ),
      ),
    );
  }
}