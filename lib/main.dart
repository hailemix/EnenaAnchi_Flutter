import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Enena Anchi'),
    );
  }
}

class MyHomePage extends StatefulWidget {

  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


      @override
  Widget build(BuildContext context) {
  
   var jsonList = DefaultAssetBundle.of(context).loadString('jsonStore/enenaAnchi.json');
 
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(8.0),
      ),
      body: Container(
          child: FutureBuilder(
              future: jsonList,
              builder: (context, snapshot) {
                var newData = json.decode(snapshot.data);
                var detailContents = newData[0]['allContent'];
                return Builder(
                  builder : (BuildContext context) {
                    return Center(       
                     child: PageView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data.length,
                          itemBuilder: (context, position){
                            return Container(
                            child: Center(
                              child: Text(detailContents[position], 
                              style: TextStyle(fontSize: 25.0)),
                            ),
                            color: position % 3 == 0 ? 
                            CupertinoColors.activeBlue : CupertinoColors.activeGreen ,
                            );
                          },                         
                     ),
                    );
                  },
                );
              })),
    );

  }
 
}
