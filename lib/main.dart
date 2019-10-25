import 'package:enena_anchi/about_us.dart';
import 'package:enena_anchi/json_model.dart';
import 'package:enena_anchi/animation_class.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:flutter/services.dart';


void main() {
 SystemChrome.setPreferredOrientations([
  DeviceOrientation.portraitUp
  ]).then((_){
  runApp(RomanceApp());
  });
}

class RomanceApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      theme: CupertinoThemeData(
        primaryColor: Colors.blue,
        textTheme: CupertinoTextThemeData(
          textStyle: TextStyle(fontFamily: 'Nyala')
        ),
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
 
    List<BottomNavigationBarItem> _bottomIcons;
    List<Color> _containerColor = [Colors.teal[700],Colors.blueGrey[600],Colors.brown[400],Colors.white];
    Animation<double> startAnimation;
    Animation<double> tapAnimation;
    AnimationController _startAnimationController;
    AnimationController _tapController;
    bool animationIsCompleted = false;
    bool isTapped = false;
    String _finalContent = '';

     @override
  void initState() {
    super.initState();

    _bottomIcons = [
     BottomNavigationBarItem(title: Text('ለአንቺ'),icon: Icon(Icons.face)),
     BottomNavigationBarItem(title: Text('ለአንተ'),icon: Icon(Icons.mood)),
     BottomNavigationBarItem(title: Text('ፍቅር'),icon: Icon(Icons.favorite_border),activeIcon: Icon(Icons.favorite_border,color: Colors.red)),
     BottomNavigationBarItem(title: Text('ስለእኛ'),icon: Icon(Icons.supervised_user_circle)),
     ];

    _startAnimationController = AnimationController(vsync: this,duration: Duration(milliseconds: 1800));
    _tapController = AnimationController(vsync: this, duration: Duration(milliseconds: 800));
    startAnimation = CurvedAnimation(parent: _startAnimationController, curve: Curves.bounceOut);
    tapAnimation = CurvedAnimation(parent: _tapController,curve: Curves.ease);
    _startAnimationController.forward();
    selectAnimation(startAnimation);
     }

     @override
    void dispose() {
    _startAnimationController.dispose();
    _tapController.dispose();
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
        items: _bottomIcons,
        onTap: (int tappedPage){
          if (tappedPage < 3) {
            isTapped = true;
            _tapController.forward(from: 0.0);
            selectAnimation(tapAnimation);
          }
        },
      ),
       tabBuilder: (BuildContext context, int tabPosition){

         return CupertinoTabView(
           builder: (BuildContext context){
            return  tabPosition < 3 ?
            Stack(
              alignment: Alignment.center,
              children: <Widget>[
                  ContainerWidget(
                  animation: isTapped ? tapAnimation: startAnimation,
                  zColor: _containerColor[tabPosition],
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
                                  _finalContent = snapshot.data.contentOne[swipePagePosition];
                                  break;
                                case 1:
                                  _finalContent = snapshot.data.contentTwo[swipePagePosition];
                                  break;
                                case 2:
                                  _finalContent = snapshot.data.contentThree[swipePagePosition];
                              }
                              return
                                Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(25.0),
                                    child: Text(
                                        _finalContent,
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
                        return Center(child: RefreshProgressIndicator(backgroundColor: CupertinoColors.white));
                      }
                  ) :
                  Text(''),
                ),
                  Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right: 40, bottom: 110),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          CupertinoButton(
                            child: Icon(CupertinoIcons.share, color: Colors.white,size: 45.0,),
                            onPressed: () {
                               SystemSound.play(SystemSoundType.click);
                               Share.share(_finalContent,subject: 'ፍቅር');
                            },
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
                //
             /*
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,

                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right: 15,left: 15,bottom: 65),
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        ),
                        child: Center(child: Text('Banner Ad'),),
                      ),
                    ),
                  ],
                ) */
              ],
            ) : AboutUs();
           },
         );
       },      
    );

  }

}















