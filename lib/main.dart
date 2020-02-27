import 'package:enena_anchi/about_us.dart';
import 'package:enena_anchi/favourites_class.dart';
import 'package:enena_anchi/information_class.dart';
import 'package:enena_anchi/messages_class.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

const String MY_APP_ID = "ca-app-pub-9156727777369518~1185879969";
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseAdMob.instance.initialize(appId: MY_APP_ID);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(
        CupertinoApp(
          home: HomeClass(),
          theme: CupertinoThemeData(
            primaryColor: Colors.blue,
            textTheme: CupertinoTextThemeData(
                textStyle: TextStyle(fontFamily: 'Nyala')),
          ),
          debugShowCheckedModeBanner: false,
        ));
  });
}

class HomeClass extends StatefulWidget {

  @override
  _HomeClassState createState() => _HomeClassState();
}

class _HomeClassState extends State<HomeClass>
    with SingleTickerProviderStateMixin {


  double sideMeasure = 160;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: CupertinoColors.white,
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Flexible(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: sideMeasure,
                      height: sideMeasure,
                      child: Material(
                          color: CupertinoColors.darkBackgroundGray,
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          child: InkWell(
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(Icons.mail, color: CupertinoColors.white,
                                    size: 30,),
                                  Padding(padding: EdgeInsets.symmetric(
                                      vertical: 3.0),),
                                  Text('መልእክቶች', style: TextStyle(
                                      fontSize: 20.0, color: Colors.white),)
                                ],
                              )
                            ),
                            onTap: () {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => RomanceApp()));
                            },
                          )
                      ),
                    ),
                    Padding(padding: EdgeInsets.symmetric(horizontal: 5.0),),
                    Container(
                      width: sideMeasure,
                      height: sideMeasure,
                      child: Material(
                        color: CupertinoColors.darkBackgroundGray,
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        child: InkWell(
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(Icons.info, color: CupertinoColors.white,
                                  size: 30,),
                                Padding(padding: EdgeInsets.symmetric(
                                    vertical: 3.0),),
                                Text('መረጃዎች', style: TextStyle(
                                    fontSize: 20.0, color: Colors.white))
                              ],
                            ),
                            ),
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => InformationClass()
                              ));
                            }
                        ),
                      ),
                    ),
                  ],
                ),
              ),

            Padding(
              padding: EdgeInsets.symmetric(vertical: 5.0),
            ),

              Flexible(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: sideMeasure,
                      height: sideMeasure,
                      child: Material(
                        color: CupertinoColors.darkBackgroundGray,
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        child: InkWell(
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(Icons.favorite_border,
                                    color: CupertinoColors.white, size: 30,),
                                  Padding(padding: EdgeInsets.symmetric(
                                      vertical: 3.0),),
                                  Text('የወደድኳቸዉ', style: TextStyle(
                                      fontSize: 20.0, color: Colors.white),),
                                ],
                              ),),
                            onTap: () {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => MyFavourites()
                                ));
                            }
                        ),
                      ),),
                    Padding(padding: EdgeInsets.symmetric(horizontal: 5.0),),

                    Container(
                      width: sideMeasure,
                      height: sideMeasure,
                      child: Material(
                          color: CupertinoColors.darkBackgroundGray,
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          child: InkWell(
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(
                                    Icons.group, color: CupertinoColors.white,
                                    size: 30,),
                                  Padding(padding: EdgeInsets.symmetric(
                                      vertical: 3.0),),
                                  Text('ስለ እኛ', style: TextStyle(
                                      fontSize: 20.0, color: Colors.white),)
                                ],
                              ),),
                            onTap: () {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => AboutUs()));
                            },
                          )
                      ),
                    ),
                  ],
                ),
              )
          ],
          )
      ),
    );
  }

}
