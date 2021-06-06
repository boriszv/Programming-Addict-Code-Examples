import 'package:flutter/material.dart';

class AppToolbar extends StatelessWidget implements PreferredSizeWidget {

  final String title;
  final List<Widget> actions;
 
  AppToolbar({
    this.title,
    this.actions = const [],
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      title: Text(title, style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.w700)),
      actions: actions,
      iconTheme: IconThemeData(
        color: Theme.of(context).primaryColor
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56.0);
}
