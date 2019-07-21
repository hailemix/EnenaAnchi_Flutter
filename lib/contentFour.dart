
import 'package:flutter/material.dart';

class ContentFour extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Page Four'),
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