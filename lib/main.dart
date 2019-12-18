import 'package:enena_anchi/about_us.dart';
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: sideMeasure,
                    height: sideMeasure,
                    child: Material(
                        color: CupertinoColors.activeBlue,
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        child: InkWell(
                          child: Center(child: Text('Messages'),),
                          onTap: () {
                            setState(() {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => RomanceApp()));
                            });
                          },
                        )
                    ),
                  ),
                  Container(
                    width: 160,
                    height: 160,
                    color: CupertinoColors.activeOrange,
                    child: Center(child: Text('Info'),),),
                ],
              ),

            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
            ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: 160,
                    height: 160,
                    color: CupertinoColors.activeGreen,
                    child: Center(child: Text('Favourites'),),),

                  Container(
                    width: sideMeasure,
                    height: sideMeasure,
                    child: Material(
                        color: CupertinoColors.lightBackgroundGray,
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        child: InkWell(
                          child: Center(child: Text(
                            'ስለ እኛ', style: TextStyle(fontSize: 30.0),),),
                          onTap: () {
                            setState(() {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => AboutUs()));
                            });
                          },
                        )
                    ),
                  ),
                ],
              )
          ],
          )
      ),
    );
  }

}
