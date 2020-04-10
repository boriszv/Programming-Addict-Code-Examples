import 'package:flutter/material.dart';

class SlideFromTopRoute extends PageRouteBuilder {
  final Widget widget;

  SlideFromTopRoute({this.widget}) : super(
    pageBuilder: (context, animation, secondaryAnimation) => widget,
    transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0.0, -1.0),
          end: Offset.zero,
        ).animate(animation),
        child: SlideTransition(
          position: Tween<Offset>(
            begin: Offset.zero,
            end: const Offset(0.0, -1.0),
          ).animate(secondaryAnimation),
          child: child,
        ),
      );
    }
  );
}