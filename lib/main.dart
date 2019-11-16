import 'package:enena_anchi/about_us.dart';
import 'package:enena_anchi/json_model.dart';
import 'package:enena_anchi/animation_class.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:flutter/services.dart';

const String MY_APP_ID = "ca-app-pub-9156727777369518~1185879969";
const String _bannerIdNumber = "ca-app-pub-9156727777369518/7886249173";
const String _interstitialIdNumber = "ca-app-pub-9156727777369518/8020534016";
const String EMULATOR_DEVICE = "Pixel 2";
const String REAL_DEVICE = "ASUS A006";
void main() {

  WidgetsFlutterBinding.ensureInitialized();
  FirebaseAdMob.instance.initialize(appId: MY_APP_ID);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(RomanceApp());
  });
}

class RomanceApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      theme: CupertinoThemeData(
        primaryColor: Colors.blue,
        textTheme:
            CupertinoTextThemeData(textStyle: TextStyle(fontFamily: 'Nyala')),
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
  List<Color> _containerColor = [
    Colors.teal[700],
    Colors.blueGrey[600],
    Colors.brown[400],
    Colors.white
  ];
  Animation<double> startAnimation;
  Animation<double> tapAnimation;
  AnimationController _startAnimationController;
  AnimationController _tapController;
  bool animationIsCompleted = false;
  bool isTapped = false;
  String _finalContent = '';
  BannerAd _bannerAd;
  InterstitialAd _myInterstitial;
  MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    keywords: <String>['enena anchi', 'amharic love quotes','amharic love letters','love letter','amharic romantic quotes'],
    contentUrl: 'https://play.google.com/store/apps/dev?id=4732824418136294157&hl=en',
    testDevices: <String>[EMULATOR_DEVICE, REAL_DEVICE],
  );

  BannerAd createBannerAd() {
    return BannerAd(
        adUnitId: BannerAd.testAdUnitId,
        //adUnitId:_bannerIdNumber,
        size: AdSize.banner,
        targetingInfo: targetingInfo,
        listener: (MobileAdEvent event) {
          print("BannerAd event is $event");
        });
  }

  @override
  void initState() {
    super.initState();


    _startAnimationController = AnimationController(vsync: this, duration: Duration(milliseconds: 1800));
    _tapController = AnimationController(vsync: this, duration: Duration(milliseconds: 800));
    startAnimation = CurvedAnimation(parent: _startAnimationController, curve: Curves.bounceOut);
    tapAnimation = CurvedAnimation(parent: _tapController, curve: Curves.ease);
    _startAnimationController.forward();
    selectAnimation(startAnimation);

    _bannerAd = createBannerAd()
      ..load()
      ..show(
          anchorOffset: 60.0,
          horizontalCenterOffset:0.0,
          anchorType: AnchorType.top);

    _myInterstitial = InterstitialAd(
        adUnitId: InterstitialAd.testAdUnitId,
       // adUnitId: _interstitialIdNumber,
        targetingInfo: targetingInfo,
        listener: (MobileAdEvent event) {

        });
  }

  @override
  void dispose() {
    _startAnimationController.dispose();
    _tapController.dispose();
    _bannerAd?.dispose();
    super.dispose();
  }

  selectAnimation(Animation<double> animType) {
    animType.addStatusListener((status) {
      setState(() {
        if (status == AnimationStatus.completed) {
          animationIsCompleted = true;
        } else {
          animationIsCompleted = false;
        }
      });
    });
  }

  void showInterstitialAd(int pageNumber) {
    _myInterstitial.load();

    if (pageNumber % 3 == 0) {
      _myInterstitial.show(
            anchorType: AnchorType.bottom,
            anchorOffset: 0.0,
         );
    }

  }

    @override
    build(BuildContext context) {

      _bottomIcons = [
        BottomNavigationBarItem(title: Text('ለአንቺ'), icon: Icon(Icons.face)),
        BottomNavigationBarItem(title: Text('ለአንተ'), icon: Icon(Icons.mood)),
        BottomNavigationBarItem(
            title: Text('ፍቅር'),
            icon: Icon(Icons.favorite_border),
            activeIcon: Icon(Icons.favorite_border, color: Colors.red)),
        BottomNavigationBarItem(
            title: Text('ስለእኛ'), icon: Icon(Icons.supervised_user_circle)),
      ];

      return CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          items: _bottomIcons,
          onTap: (int tappedPage) {
            if (tappedPage < 3) {
              isTapped = true;
              _tapController.forward(from: 0.0);
              selectAnimation(tapAnimation);
            }
          },
        ),
        tabBuilder: (BuildContext context, int tabPosition) {
          return CupertinoTabView(
            builder: (BuildContext context) {
              return tabPosition < 3
                  ? Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  ContainerWidget(
                    animation: isTapped ? tapAnimation : startAnimation,
                    zColor: _containerColor[tabPosition],
                    theContainer: animationIsCompleted
                        ? FutureBuilder<JsonContent>(
                        future: loadContent(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return PageView.builder(
                              scrollDirection: Axis.horizontal,
                              onPageChanged: showInterstitialAd,
                              itemBuilder:
                                  (context, swipePagePosition) {
                                switch (tabPosition) {
                                  case 0:
                                    _finalContent = snapshot.data
                                        .contentOne[swipePagePosition];
                                    break;
                                  case 1:
                                    _finalContent = snapshot.data
                                        .contentTwo[swipePagePosition];
                                    break;
                                  case 2:
                                    _finalContent =
                                    snapshot.data.contentThree[
                                    swipePagePosition];
                                }
                                return Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(25.0),
                                    child: Text(_finalContent,
                                        style: TextStyle(
                                          fontSize: 35.0,
                                          decoration:
                                          TextDecoration.none,
                                          color: Colors.white,
                                        )),
                                  ),
                                );
                              },
                            );
                          } else if (snapshot.hasError) {
                            return Center(
                                child: Text(
                                    "Fetching data has an error.Details: ${snapshot
                                        .error}"));
                          }
                          return Center(
                              child: RefreshProgressIndicator(
                                  backgroundColor:
                                  CupertinoColors.white));
                        })
                        : Text(''),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Padding(
                        padding:
                        const EdgeInsets.only(right: 40, bottom: 110),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            CupertinoButton(
                              child: Icon(
                                CupertinoIcons.share,
                                color: Colors.white,
                                size: 45.0,
                              ),
                              onPressed: () {
                                SystemSound.play(SystemSoundType.click);
                                Share.share(_finalContent, subject: 'ፍቅር');
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              )
            : AboutUs();
            },
          );
        },
      );
    }
  }

