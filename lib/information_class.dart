import 'package:enena_anchi/information_details.class.dart';
import 'package:enena_anchi/information_json_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InformationClass extends StatefulWidget {
  @override
  InformationClassState createState() => InformationClassState();
}

class InformationClassState extends State<InformationClass> {
  String zBestContents = "";
  List<String> contentTitles = [
    'ስትበስል የምትረዳቸዉ ነገሮች',
    'የማርታ እይታ',
    'ሴቶችን በተመለከተ',
    'የሚጎትተዉ እንቅፋት',
    'የቀድሞ ፍቅረኛዬ',
    'ምርጥ አባባሎች',
    'አንዳንድ ቀን',
    'መግለጫ',
    'አዙሪት',
    'የፍቅር ቆይታ',
    'በራስ የሚተማመን',
    'ባሌ ምን እያሰበ ነዉ?',
    'የዉሸት ጓደኞች',
    'የሰዎች አሳዛኝ ባህሪ',
    'ወንድ ልጅ ሲያፈቅር',
    'አስቸጋሪ ሴቶች',
    'የፍቺ ነገር',
    'ፍቅርና ግንኙነት',
    'ቅናት',
    'ምርጥ ብቀላ'
  ];


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
            color: Colors.white,
            child: informationJsonAccessor()

        ),
      ),
    );
  }

  Widget informationJsonAccessor() {
    return FutureBuilder<InformationJsonContent>(
      future: loadInformationContent(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Padding(
            padding: const EdgeInsets.only(top: 50.0, bottom: 30.0),
            child: ListView.builder(
              itemCount: 20,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: ListTile(
                    trailing: Icon(CupertinoIcons.forward),
                    title: Text(
                      '${contentTitles[index]}',
                      style: TextStyle(fontSize: 20.0),
                    ),
                    onTap: () async {
                      zBestContents = snapshot.data.allContents[index];
                      await Navigator.push(context,
                          InformationClassBackRoute(builder: (context) =>
                              InformationDetails(infoContent: zBestContents,
                                title: contentTitles[index],)));
                    },
                  ),
                );
              },
            ),
          );

        } else if (snapshot.hasError) {
          return Center(
              child: Text(
                  "Fetching data has an error.Details: ${snapshot.error}"));
        }

        return Center(
          child: RefreshProgressIndicator(
            backgroundColor: CupertinoColors.black,
          ),
        );
      },
    );
  }
}

class InformationClassBackRoute<T> extends MaterialPageRoute<T> {
  InformationClassBackRoute({WidgetBuilder builder, RouteSettings settings})
      : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    if (settings.isInitialRoute) return child;
    return ScaleTransition(
      scale: animation,
      child: child,
    );
  }
}
