import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget with PreferredSizeWidget {
  final PreferredSizeWidget bottom;
  MyAppBar({this.bottom});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      flexibleSpace: Container(
          // decoration: new BoxDecoration(
          //   gradient: new LinearGradient(
          //     colors: [Colors.pink, Colors.lightGreenAccent],
          //     begin: const FractionalOffset(0.0, 0.0),
          //     end: const FractionalOffset(1.0, 0.0),
          //     stops: [0.0, 1.0],
          //     tileMode: TileMode.clamp,
          //   ),
          // ),
          ),
      title: Text(
        "e-Shop",
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
      centerTitle: true,
    );
  }

  Size get preferredSize => bottom == null
      ? Size(56, AppBar().preferredSize.height)
      : Size(56, 80 + AppBar().preferredSize.height);
}
