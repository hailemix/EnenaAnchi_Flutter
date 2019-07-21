import 'dart:convert';
import 'package:enena_anchi/contentTwo.dart';
import 'package:enena_anchi/flip_navigation/flip_bar_item.dart';
import 'package:enena_anchi/flip_navigation/flip_box.dart';
import 'package:enena_anchi/flip_navigation/flip_box_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Enena Anchi'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {

  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  
  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {

    int selectedIndex = 0;
   String selectedContent = 'contentOne'; 

      @override
  Widget build(BuildContext context) {
   var jsonList = DefaultAssetBundle.of(context).loadString('jsonStore/enenaAnchi.json');
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      bottomNavigationBar: FlipBoxBar(
      selectedIndex:  selectedIndex,
      items: [
        FlipBarItem(icon: Icon(Icons.face),text: Text("Love"), fontColor: CupertinoColors.activeBlue, backColor: CupertinoColors.lightBackgroundGray),
        FlipBarItem(icon: Icon(Icons.satellite),text: Text("Memory"), fontColor: CupertinoColors.activeOrange, backColor: CupertinoColors.extraLightBackgroundGray),
        FlipBarItem(icon: Icon(Icons.games),text: Text("Passion"), fontColor: CupertinoColors.activeGreen, backColor: CupertinoColors.darkBackgroundGray),
        FlipBarItem(icon: Icon(Icons.account_box),text: Text("About Us"), fontColor: CupertinoColors.destructiveRed, backColor: CupertinoColors.inactiveGray),
      ],
      onIndexChanged: (newIndex){
        setState(() {
          selectedIndex = newIndex;
        }
        );
      },
      ),
      body: Container(
          child: FutureBuilder(
              future: jsonList,
              builder: (context, snapshot) {
                var newData = json.decode(snapshot.data); 
           
                var detailContents = newData[0][selectedContent];
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
                            color: position % 3 == 0 ?  CupertinoColors.activeBlue : CupertinoColors.activeGreen ,
                            );
                          },                         
                     ),
                     
                    );
                  },
                  
                );
              },
              
              
              )),
    );

  }
 
}
