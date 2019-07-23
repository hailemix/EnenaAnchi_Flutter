import 'dart:convert';
import 'dart:io';
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

   String selectedContent; 
   List<BottomNavigationBarItem> bottomIcons;
   var jsonList;
   var detailContents;

     @override
  void initState() {
    super.initState();
    selectedContent = 'contentOne';
   jsonList = DefaultAssetBundle.of(context).loadString('jsonStore/enenaAnchi.json'); 
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
        onTap: (int index){
          setState(() {
            
          });
        },

      ),
       tabBuilder: (BuildContext context, int position){
         return CupertinoTabView(
           builder: (BuildContext context){
             return Container(
          child: FutureBuilder(
              future: jsonList,
              builder: (context, snapshot) {
               
               try {
                   var newData = json.decode(snapshot.data);
                   detailContents = newData[0][selectedContent];  
                   switch(position){
                     case 0:
                     selectedContent = "contentOne";
                     break;
                     case 1:
                     selectedContent = "contentTwo";
                     break;
                     case 2:
                     selectedContent = "contentThree";
                     break;
                     case 3:
                     selectedContent = "contentThree";
                     break;
                     default:
                     selectedContent = "contentOne";
                   }  
               }   catch(e){
               print("Error is found on $e");
              }
                return Builder(
                  builder : (BuildContext context) {
                    return Center(       
                     child: PageView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data != null ? snapshot.data.length : null,
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
              }
            
              
              
              ));
           },
         );
       },
       
    );

  }
 
}
