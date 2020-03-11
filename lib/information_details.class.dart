import 'package:enena_anchi/information_class.dart';
import 'package:enena_anchi/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InformationDetails extends StatefulWidget {
  final String infoContent;
  final String title;

  InformationDetails(
      {Key key, @required this.infoContent, @required this.title})
      : super(key: key);

  @override
  _InformationDetailsState createState() => _InformationDetailsState();
}

class _InformationDetailsState extends State<InformationDetails> {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      debugShowCheckedModeBanner: false,

      home: CupertinoPageScaffold(

        navigationBar: CupertinoNavigationBar(
          backgroundColor: Colors.white,
          middle: Text(
            widget.title, style: TextStyle(color: CupertinoColors.black),),
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
          trailing: CupertinoButton(
            child: Icon(
              CupertinoIcons.home,
              color: CupertinoColors.activeBlue,
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HomeClass()));
            },
          ),
        ),
        child: Column(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5.0, top: 40.0),
                    child: Text(widget.infoContent,
                      style: TextStyle(fontSize: 16.0,),),
                  ),
                ),
              ),
            ]
        ),
      ),
    );
  }
}
