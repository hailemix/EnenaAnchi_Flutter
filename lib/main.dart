import 'package:enena_anchi/about_us.dart';
import 'package:enena_anchi/json_model.dart';
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
    var finalContent = '';
  

     @override
  void initState() {
    super.initState();
 
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
                           
                          switch(tabPosition){
                            case 0:
                            finalContent = snapshot.data.contentOne[swipePagePosition];
                            break;
                            case 1:
                            finalContent = snapshot.data.contentTwo[swipePagePosition];
                            break;
                            case 2:
                            finalContent = snapshot.data.contentThree[swipePagePosition];
                            break;
                            case 3:
                            return  AboutUs();
                  
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
                         return Center(child: Text("${snapshot.error}"));
                       } 
                       return Center(child: CircularProgressIndicator());
       
              }
            
              
              
              ));
           },
         );
       },
       
    );

  }
 
}















