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

  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.white, child: informationJsonAccessor());
  }

  Widget informationJsonAccessor() {
    return FutureBuilder<InformationJsonContent>(
      future: loadInformationContent(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: 10,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 50.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: Colors.grey),
                    child: Text(
                      'Hello $index ****',
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                ),
                onTap: () async {
                  zBestContents = snapshot.data.allContents[index];
                  await Navigator.push(
                      context,
                      InformationClassBackRoute(
                          builder: (context) =>
                              InformationDetails(infoContent: zBestContents)));
                },
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
