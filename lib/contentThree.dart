
import 'package:flutter/material.dart';

class ContentThree extends StatefulWidget {
  @override
  _ContentTwoState createState() => _ContentTwoState();
}

class _ContentTwoState extends State<ContentThree> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Page Three'),
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