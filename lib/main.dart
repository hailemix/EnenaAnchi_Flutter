
import 'package:enena_anchi/about_us.dart';
import 'package:enena_anchi/json_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      theme: CupertinoThemeData(
        primaryColor: Colors.blue,
        textTheme: CupertinoTextThemeData(textStyle: TextStyle(fontFamily: 'Ethiopia Jiret'))
       
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
    List containerColor = [Colors.teal[400],Colors.blueGrey,Colors.brown[300],Colors.white];
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
        onTap: (int tappedPage){
           
        },
  
      ),
       tabBuilder: (BuildContext context, int tabPosition){
         
           
         return CupertinoTabView(
           builder: (BuildContext context){   
              
             return Stack(
              alignment: Alignment.center,
               children: <Widget>[
                 Container(
                   width: 350,
                   height: 500,
               decoration: BoxDecoration(
                 color: containerColor[tabPosition],
                 border: Border.all(color: Colors.white,style: BorderStyle.solid),
                 borderRadius: BorderRadius.all(Radius.circular(15.0)),
                 shape: BoxShape.rectangle
                 ),
              
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
                            return 
                               Center(
                                child: Text(finalContent , 
                                style: TextStyle(fontSize: 35.0,decoration: TextDecoration.none,color: Colors.white,
                                )),
                              );
                          },
                         );
                       } else if(snapshot.hasError){
                         return Center(child: Text("${snapshot.error}"));
                       } 
                       return Center(child: CircularProgressIndicator());     
              }
   ))
               ],
             );
           },
         );
       },
       
    );

  }
 
}















