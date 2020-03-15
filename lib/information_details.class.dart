import 'dart:async';

import 'package:enena_anchi/information_class.dart';
import 'package:enena_anchi/main.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const String _BANNER = "ca-app-pub-9156727777369518/7886249173";
const String _INTERSTITIAL = "ca-app-pub-9156727777369518/8020534016";


class InformationDetails extends StatefulWidget {
  final String infoContent;
  final String title;


  InformationDetails(
      {Key key, @required this.infoContent, @required this.title})
      : super(key: key);

  @override
  _InformationDetailsState createState() => _InformationDetailsState();
}

class _InformationDetailsState extends State<InformationDetails> {

  BannerAd _bannerAd;
  InterstitialAd _myInterstitial;
  ScrollController _scrollController = ScrollController();
  MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    keywords: <String>[
      'enena anchi',
      'amharic love quotes',
      'amharic literature',
      'ethiopian life ',
      'amharic romantic quotes',
      'ethiopian romance',
      'ethiopian life style'
    ],
    contentUrl:
    'https://play.google.com/store/apps/dev?id=4732824418136294157&hl=en',
    testDevices: ["iPhone 6s"]
  );


  BannerAd createBannerAd() {
    return BannerAd(
   //   adUnitId: _BANNER,
      adUnitId: BannerAd.testAdUnitId,
      size: AdSize.smartBanner,
      targetingInfo: targetingInfo,
    );
  }

  InterstitialAd createInterstitialAd() {
    return InterstitialAd(
      adUnitId: InterstitialAd.testAdUnitId,
      targetingInfo: targetingInfo
    );
  }
  @override
  void initState() {
    super.initState();

    _myInterstitial = createInterstitialAd();
    _bannerAd = createBannerAd()
      ..load()
      ..show(
          anchorOffset: 0.0,
          horizontalCenterOffset: 0.0,
          anchorType: AnchorType.bottom
      );
    _scrollController.addListener(() {
      double maxScroll = _scrollController.position.maxScrollExtent;
      double currentScroll = _scrollController.position.pixels;
      double adZone = 1.0;
      _myInterstitial.load();
      if(maxScroll - currentScroll <= adZone) {

        Timer(Duration(seconds: 20),() {
          _myInterstitial.show(
              anchorType: AnchorType.bottom,
              anchorOffset: 0.0
          );
        });

      }
    });
  }


  @override
  void dispose() {
    _bannerAd.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return CupertinoApp(
      debugShowCheckedModeBanner: false,

      home: CupertinoPageScaffold(

        navigationBar: CupertinoNavigationBar(
          backgroundColor: Colors.white,
          middle: Text(
            widget.title, style: TextStyle(color: CupertinoColors.black),),
          leading: CupertinoButton(
            child: Icon(
              CupertinoIcons.back,
              color: CupertinoColors.activeBlue,
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => InformationClass()));
            },
          ),
          trailing: CupertinoButton(
            child: Icon(
              CupertinoIcons.home,
              color: CupertinoColors.activeBlue,
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HomeClass()));
            },
          ),
        ),
        child: Column(
            children: <Widget>[
              Expanded(
                flex: 1,
                child:Scrollbar(
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5.0, top: 40.0),
                      child: Text(widget.infoContent, style: TextStyle(fontSize: 16.0,),),
                    ),
                  ),
                ),
              ),
            ]
        ),
      ),
    );
  }

}
