import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ContentTwo extends StatefulWidget {
  @override
  _ContentTwoState createState() => _ContentTwoState();
}

class _ContentTwoState extends State<ContentTwo> {
  @override
  Widget build(BuildContext context) {
    return   Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Page Two'),
            FlatButton(
          onPressed: (){
            Navigator.pop(context);
          },
          child: Text('Back',style: TextStyle(color: Colors.white),),
        ),
          ],
        )
    ),
    );
  }
}