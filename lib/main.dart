import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


Future<String>  _loadContents() async {
return await rootBundle.loadString('jsonStore/enenaAnchi.json');
}

Future<JsonContent> loadContent() async {
   await wait(400);
  String jsonString = await _loadContents();
  final jsonResponse = json.decode(jsonString);
  return JsonContent.fromJson(jsonResponse);

}

Future wait(int millisecond) {
  return Future.delayed(Duration(milliseconds: 400),() => {});
}

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {

  
  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
 
    List<BottomNavigationBarItem> bottomIcons;
    List containerColor = [Colors.teal[200],Colors.blue[200],Colors.brown[200],Colors.cyan[200]];
    //String selectedContent;
   // var detailContents;
  

     @override
  void initState() {
    super.initState();
   // selectedContent = 'contentOne';
    bottomIcons = [
     BottomNavigationBarItem(title: Text('Love'),icon: Icon(Icons.language)),
     BottomNavigationBarItem(title: Text('Balads'),icon: Icon(Icons.satellite)),
     BottomNavigationBarItem(title: Text('Sad'),icon: Icon(Icons.face)),
     BottomNavigationBarItem(title: Text('About Us'),icon: Icon(Icons.album)),
     ];
  }
   
      @override
  Widget build(BuildContext context) {

 
   
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: bottomIcons,
  
      ),
       tabBuilder: (BuildContext context, int tabPosition){
         
         return CupertinoTabView(
           builder: (BuildContext context){   
              
             return Container(
               color: containerColor[tabPosition],
          child: FutureBuilder<JsonContent>(
              future: loadContent(),
              builder: (context, snapshot) {
                       if(snapshot.hasData){
                         return PageView.builder(
                              scrollDirection: Axis.horizontal,
                          
                          itemBuilder: (context, swipePagePosition){
                           var finalContent = '';
                          switch(tabPosition){
                            case 0:
                            finalContent = snapshot.data.contentOne[swipePagePosition];
                            break;
                            case 1:
                            finalContent = snapshot.data.contentTwo[swipePagePosition];
                            break;
                            case 2:
                            finalContent = snapshot.data.contentThree[swipePagePosition];
                          }
                          
                            return Container(
                            child: Center(
                              child: Text(finalContent , 
                              style: TextStyle(fontSize: 25.0)),
                            ),
                            
                            );
                          },
                         );
                       } else if(snapshot.hasError){
                         return Text("${snapshot.error}");
                       } 
                       return Center(child: CircularProgressIndicator());
               /*
                return Builder(
                  builder : (BuildContext context) {
                    return Center(       
                     child: PageView.builder(
                        scrollDirection: Axis.horizontal,
                          
                          itemBuilder: (context, swipePagePosition){
                          
                            return Container(
                            child: Center(
                              child: Text(detailContents[swipePagePosition] , 
                              style: TextStyle(fontSize: 25.0)),
                            ),
                            
                            );
                          },                         
                     ),
                     
                    );
                  },
                  
                );
                */
              }
            
              
              
              ));
           },
         );
       },
       
    );

  }
/*
  Future loadContent() async {
    var jsonList = await DefaultAssetBundle.of(context).loadString('jsonStore/enenaAnchi.json');  
     final newData = json.decode(jsonList);
     return newData;
  }

  */
 
}

class JsonContent {

  List<String> contentOne;
  List<String> contentTwo;
  List<String> contentThree;
  JsonContent({this.contentOne,this.contentTwo,this.contentThree});

  factory JsonContent.fromJson(Map<String, dynamic> parsedJson){

 List<String> contentOneData = parsedJson['contentOne'].cast<String>();
 List<String> contentTwoData = parsedJson['contentTwo'].cast<String>();
 List<String> contentThreeData = parsedJson['contentThree'].cast<String>();
     return JsonContent(
       contentOne: contentOneData,
       contentTwo: contentTwoData,
       contentThree: contentThreeData
     );
  }
}




















