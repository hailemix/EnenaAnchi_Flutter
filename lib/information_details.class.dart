import 'package:enena_anchi/information_class.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InformationDetails extends StatefulWidget {
  final String infoContent;

  InformationDetails({Key key, @required this.infoContent}) : super(key: key);

  @override
  _InformationDetailsState createState() => _InformationDetailsState();
}

class _InformationDetailsState extends State<InformationDetails> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Best Contents'),
          leading: CupertinoButton(
            child: Icon(
              CupertinoIcons.back,
              color: CupertinoColors.activeBlue,
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => InformationClass()));
            },
          ),
        ),
        body: Center(child: Text(widget.infoContent)),
      ),
    );
  }
}
