import 'package:enena_anchi/database_bloc.dart';
import 'package:enena_anchi/favourite_model.dart';
import 'package:enena_anchi/json_model.dart';
import 'package:enena_anchi/animation_class.dart';
import 'package:enena_anchi/main.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:flutter/services.dart';
import 'dart:io';

const String _BANNER = "ca-app-pub-9156727777369518/7886249173";
const String _INTERSTITIAL = "ca-app-pub-9156727777369518/8020534016";

class RomanceApp extends StatefulWidget {

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<RomanceApp> with TickerProviderStateMixin {


  List<BottomNavigationBarItem> bottomIcons;
  List<Color> _containerColor = [
    Colors.teal[700],
    Colors.blueGrey[600],
    Colors.brown[400]
  ];
  Animation<double> startAnimation;
  Animation<double> tapAnimation;
  AnimationController _startAnimationController;
  AnimationController _tapAnimationController;
  bool animationIsCompleted = false;
  bool isTapped = false;
  String finalContent = '';
  BannerAd _bannerAd;
  InterstitialAd _myInterstitial;
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    keywords: <String>[
      'enena anchi',
      'amharic love quotes',
      'amharic love ',
      'ethiopian love ',
      'amharic romantic quotes',
      'ethiopian romance'
    ],
    contentUrl:
    'https://play.google.com/store/apps/dev?id=4732824418136294157&hl=en',
  );

  String favouriteButton = "Unlike";
  final FlareControls controls = FlareControls();
  bool contentIsLiked = false;
  String tabTitle = '';
  final bloc = FavouriteBloc();
  List<FavouriteContent> testFavourites;


  BannerAd createBannerAd() {
    return BannerAd(
        adUnitId: _BANNER,
        size: AdSize.banner,
        targetingInfo: targetingInfo,
        listener: (MobileAdEvent event) {
          print("BannerAd event is $event");
        });
  }

  InterstitialAd createInterstitialAd() {
    return InterstitialAd(
        adUnitId: _INTERSTITIAL,
        targetingInfo: targetingInfo,
        listener: (MobileAdEvent event) {
          if (event == MobileAdEvent.failedToLoad ||
              event == MobileAdEvent.closed) {
            _myInterstitial.load();
          }
        });
  }

  void firebaseCloudMessagingListeners() {
    if (Platform.isIOS) iOSPermission();

    _firebaseMessaging.getToken().then((token) {
      print(token);
    });

    _firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
          print('on message $message');
        }, onResume: (Map<String, dynamic> message) async {
      print('on resume $message');
    }, onLaunch: (Map<String, dynamic> message) async {
      if (message.isNotEmpty) {
        _myInterstitial.load();
        _myInterstitial.show();
      }
    });
  }

  void iOSPermission() {
    _firebaseMessaging.requestNotificationPermissions(
        IosNotificationSettings(sound: true, badge: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
  }

  @override
  void initState() {
    super.initState();

    _startAnimationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1800));
    _tapAnimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 800));
    startAnimation = CurvedAnimation(
        parent: _startAnimationController, curve: Curves.bounceOut);
    tapAnimation =
        CurvedAnimation(parent: _tapAnimationController, curve: Curves.ease);
    _startAnimationController.forward();
    selectAnimation(startAnimation);
    firebaseCloudMessagingListeners();

    bottomIcons = [
      BottomNavigationBarItem(title: Text('ለአንቺ'), icon: Icon(Icons.face)),
      BottomNavigationBarItem(title: Text('ለአንተ'), icon: Icon(Icons.mood)),
      BottomNavigationBarItem(
          title: Text('እዉነታ'), icon: Icon(Icons.event_note)),
    ];

    _bannerAd = createBannerAd()
      ..load()
      ..show(
          anchorOffset: 120.0,
          horizontalCenterOffset: 0.0,
          anchorType: AnchorType.top);
  }

  @override
  void dispose() {
    _startAnimationController.dispose();
    _tapAnimationController.dispose();
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: bottomIcons,
        onTap: (int tappedPage) {
          isTapped = true;
          _tapAnimationController.forward(from: 0.0);
          selectAnimation(tapAnimation);
        },
      ),
      tabBuilder: (BuildContext context, int tabPosition) {
        return CupertinoTabView(
          builder: (BuildContext context) {
            return stackWidget(tabPosition);
          },

        );
      },
    );
  }

  double opacityChanger() {
    double opacityValue;

    if (animationIsCompleted) {
      opacityValue = 1.0;
    } else {
      opacityValue = 0.0;
    }

    return opacityValue;
  }

  String changeTitle(int zTabPosition) {
    switch (zTabPosition) {
      case 0:
        tabTitle = 'ለአንቺ';
        break;
      case 1:
        tabTitle = 'ለአንተ';
        break;
      case 2:
        tabTitle = 'እዉነታ';
        break;
      default:
        tabTitle = 'ለአንቺ';
    }
    return tabTitle;
  }

  Widget stackWidget(int tabPosition) {
    changeTitle(tabPosition);
    return Stack(
      children: <Widget>[
        Align(
          alignment: Alignment.center,
          child: ContainerWidget(
            animation: isTapped ? tapAnimation : startAnimation,
            zColor: _containerColor[tabPosition],
            theContainer: animationIsCompleted
                ? jsonAccessor(tabPosition)
                : Text(''),
          ),
        ),
        CupertinoNavigationBar(
          leading: Opacity(
            opacity: opacityChanger(),
            child: CupertinoButton(
              child: Icon(
                CupertinoIcons.back,
                color: CupertinoColors.activeBlue,
                size: 30.0,
              ),
              onPressed: () {
                Navigator.pushReplacement(
                    context, BackRoute(builder: (context) => HomeClass()));
              },
            ),
          ),
          middle: Text(tabTitle, style: TextStyle(fontSize: 20.0),),
          trailing: Opacity(
            opacity: opacityChanger(),
            child: CupertinoButton(
              child: Icon(
                CupertinoIcons.share,
                color: CupertinoColors.black,
                size: 25.0,
              ),
              onPressed: () {
                SystemSound.play(SystemSoundType.click);
                Share.share(finalContent, subject: 'ፍቅር');
              },
            ),
          ),
        ),
        Positioned(
          bottom: 100,
          right: 35,
          child: Opacity(
            opacity: opacityChanger(),
            child: GestureDetector(
              child: Container(
                width: 70.0,
                height: 70.0,
                child: FlareActor("images/like_button.flr", animation: favouriteButton, controller: controls),

              ),
              onTap: () async {
                FavouriteContent zContent = testFavourites[0];
                setState(() {
                  controls.play("Like");
                  bloc.add(
                      zContent); // Add to the favourite content to Database
                });
              },
            ),

          ),
        ),
      ],
    );
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
    controls.play("Unlike");
    _myInterstitial = createInterstitialAd();
    _myInterstitial.load();
    if (pageNumber % 3 == 0) {
      _myInterstitial.show(
        anchorType: AnchorType.bottom,
        anchorOffset: 0.0,
      );
    }
  }

  Widget jsonAccessor(int zTabPosition) {
    return FutureBuilder<JsonContent>(
        future: loadContent(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return PageView.builder(
              scrollDirection: Axis.horizontal,
              onPageChanged: showInterstitialAd,
              itemBuilder: (context, swipePagePosition) {
                switch (zTabPosition) {
                  case 0:
                    finalContent = snapshot.data.contentOne[swipePagePosition];
                    break;
                  case 1:
                    finalContent = snapshot.data.contentTwo[swipePagePosition];
                    break;
                  case 2:
                    finalContent =
                    snapshot.data.contentThree[swipePagePosition];
                }
                testFavourites =
                [FavouriteContent(favouriteContent: finalContent)];
                return Center(
                  child: Padding(
                    padding: EdgeInsets.all(25.0),
                    child: Text(finalContent,
                        style: TextStyle(
                          fontSize: 35.0,
                          decoration: TextDecoration.none,
                          color: Colors.white,
                        )),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
                child: Text(
                    "Fetching data has an error.Details: ${snapshot.error}"));
          }
          return Center(
              child: RefreshProgressIndicator(
                  backgroundColor: CupertinoColors.white));
        });
  }
}

class BackRoute<T> extends MaterialPageRoute<T> {
  BackRoute({WidgetBuilder builder, RouteSettings settings})
      : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    if (settings.isInitialRoute) return child;
    return ScaleTransition(
      scale: Tween<double>(
        begin: 0.0,
        end: 1.0,
      ).animate(
        CurvedAnimation(parent: animation, curve: Curves.fastOutSlowIn),
      ),
      child: child,
    );
  }
}
