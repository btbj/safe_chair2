import 'package:flutter/material.dart';

class CustomAppBar extends AppBar {
  CustomAppBar({
    Key key,
    Widget title,
    List<Widget> actions,
    Widget leading,
    Color backgroundColor,
    Brightness brightness,
    IconThemeData iconTheme,
  }) : super(
          key: key,
          title: title,
          actions: actions,
          leading: leading,
          elevation: 0,
          backgroundColor: backgroundColor,
          brightness: brightness,
          iconTheme: iconTheme,
        );

  Size get preferredSize => Size.fromHeight(120);
}

class BottomArea extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  final Widget child;
  final EdgeInsetsGeometry padding;
  BottomArea({@required this.height, this.padding, this.child});

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? EdgeInsets.all(20),
      child: child,
    );
  }
}
