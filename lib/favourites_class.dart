import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyFavourites extends StatefulWidget {
  @override
  MyFavouritesState createState() => MyFavouritesState();
}

class MyFavouritesState extends State<MyFavourites> {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      home: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[Text('Value 1'), Text('Value 2')],
        ),
      ),
    );
  }
}
