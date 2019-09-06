import 'package:enena_anchi/about_us.dart';
import 'package:enena_anchi/json_model.dart';
import 'package:enena_anchi/animation_class.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      theme: CupertinoThemeData(
        primaryColor: Colors.blue,
        textTheme: CupertinoTextThemeData(
          textStyle: TextStyle(fontFamily: 'Nyala'))     
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

class MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
 
    List<BottomNavigationBarItem> bottomIcons;
    List containerColor = [Colors.teal[700],Colors.blueGrey[600],Colors.brown[400],Colors.white];
    Animation<double> startAnimation;
    Animation<double> tapAnimation;
    AnimationController startAnimationController;
    AnimationController tapController;
    bool animationIsCompleted = false;
    bool isTapped = false;
    String finalContent = '';

     @override
  void initState() {
    super.initState();
 
    bottomIcons = [
     BottomNavigationBarItem(title: Text('ለአንቺ'),icon: Icon(Icons.face)),
     BottomNavigationBarItem(title: Text('ለአንተ'),icon: Icon(Icons.mood)),
     BottomNavigationBarItem(title: Text('ፍቅር'),icon: Icon(Icons.favorite_border),activeIcon: Icon(Icons.favorite_border,color: Colors.red)),
     BottomNavigationBarItem(title: Text('ስለእኛ'),icon: Icon(Icons.supervised_user_circle)),
     ];
    startAnimationController = AnimationController(vsync: this,duration: Duration(milliseconds: 1800));
    tapController = AnimationController(vsync: this, duration: Duration(milliseconds: 800));
    startAnimation = CurvedAnimation(parent: startAnimationController, curve: Curves.bounceOut);
    tapAnimation = CurvedAnimation(parent: tapController,curve: Curves.ease);
    startAnimationController.forward();
    selectAnimation(startAnimation);
    selectAnimation(tapAnimation);
     }

     @override
  void dispose() {
    startAnimationController.dispose();
    tapController.dispose();
    super.dispose();
  }

     selectAnimation(Animation<double> animType){

      animType.addStatusListener((status){
        setState(() {
          if (status == AnimationStatus.completed) {
            animationIsCompleted = true;
          } else {
            animationIsCompleted = false;
          }
        });
      });

    }

  void showInterstitialAd(int pageNumber){
       if (pageNumber % 3 == 0) {
         print('Interstitial ad $pageNumber');
         //TODO Replace with Interstitial Ad.
       }
  }

      @override
   build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: bottomIcons,
        onTap: (int tappedPage){
          if (tappedPage < 3) {
            isTapped = true;
            tapController.forward(from: 0.0).whenComplete(selectAnimation(tapAnimation));

          }
        },

      ),
       tabBuilder: (BuildContext context, int tabPosition){

         return CupertinoTabView(
           builder: (BuildContext context){
            return  tabPosition < 3 ? Stack(
              alignment: Alignment.center,
              children: <Widget>[
                ContainerWidget(
                  animation: isTapped ? tapAnimation: startAnimation,
                  zColor: containerColor[tabPosition],
                  theContainer: animationIsCompleted ?
                  FutureBuilder<JsonContent>(
                      future: loadContent(),
                      builder: (context, snapshot) {
                        if(snapshot.hasData){
                          return PageView.builder(
                            scrollDirection: Axis.horizontal,
                            onPageChanged: showInterstitialAd,
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
                              }
                              return
                                Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(25.0),
                                    child: Text(
                                        finalContent,
                                        style: TextStyle(
                                          fontSize: 35.0,
                                          decoration: TextDecoration.none,
                                          color:Colors.white,
                                        )),
                                  ),
                                );
                            },
                          );
                        } else if(snapshot.hasError){
                          return Center(child: Text("Fetching data has an error.Details: ${snapshot.error}"));
                        }
                        return Center(child: CircularProgressIndicator(backgroundColor: CupertinoColors.activeOrange,));
                      }
                  ) : Text(''),),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right: 40,bottom: 110),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          CupertinoButton(
                            child: Icon(CupertinoIcons.share, color: Colors.white,size: 45.0,),
                            onPressed: (){
                              Share.share(finalContent,subject: 'ፍቅር');
                            },),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ) : AboutUs();
           },

         );
       },      
    );

  }

}















