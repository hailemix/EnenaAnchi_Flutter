import 'package:enena_anchi/database_bloc.dart';
import 'package:enena_anchi/favourite_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyFavourites extends StatefulWidget {
  @override
  MyFavouritesState createState() => MyFavouritesState();
}

class MyFavouritesState extends State<MyFavourites> {

  final bloc = FavouriteBloc();
  double _width = 180;
  double _height = 70;
  Color _color = Colors.white70;
  double _opacity = 1.0;
  BorderRadiusGeometry _borderRadius = BorderRadius.circular(10);
  final snackBar = SnackBar(content: Text('የወደዷቸዉን ጥቅሶች  ሲመርጡ  እዚህ ይቀመጣሉ!'));

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      debugShowCheckedModeBanner: false,
      home: CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
              leading: CupertinoButton(
                  child: Icon(CupertinoIcons.back, size: 30.0,),
                  onPressed: () {
                Navigator.pop(context);
                  }),
            backgroundColor: CupertinoColors.lightBackgroundGray,
          ),
          child: Scaffold(
            body: Container(
              decoration: BoxDecoration(
                color: CupertinoColors.lightBackgroundGray,
              ),
              child: StreamBuilder<List<FavouriteContent>>(
                stream: bloc.favourites,
                builder: (BuildContext context,
                    AsyncSnapshot<List<FavouriteContent>> snapshot) {
                  if (snapshot.hasData && snapshot.data.length > 0) {
                    return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        FavouriteContent content = snapshot.data[index];
                        return Dismissible(
                            key: UniqueKey(),
                            background: Container(color: Colors.red),
                            onDismissed: (direction) {
                              bloc.delete(content.id);
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(color: Theme
                                                .of(context)
                                                .dividerColor))
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(25.0),
                                      child: SelectableText(
                                        content.favouriteContent,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20.0),
                                        scrollPhysics: ClampingScrollPhysics(),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )

                        );
                      },
                    );
                  }
                  else {
                    return Opacity(
                      opacity: _opacity,
                      child: Material(
                        child: InkWell(
                          child: Center(
                            child: AnimatedContainer(
                              width: _width,
                              height: _height,
                              curve: Curves.easeIn,
                              duration: Duration(milliseconds: 400),
                              decoration: BoxDecoration(
                                  color: _color,
                                  borderRadius: _borderRadius,
                                  border: Border.all(width: 1.0,
                                      style: BorderStyle.solid,
                                      color: Colors.black38)
                              ),
                              child: Center(
                                  child: Text(
                                    'ባዶ ነዉ!', style: TextStyle(fontSize: 20),
                                  )),
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              if (_opacity == 1) {
                                _opacity = 0.0;
                                Scaffold.of(context).showSnackBar(snackBar);
                              } else {
                                _opacity = 1.0;
                              }
                            });
                          },
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          )
      ),
    );
  }
}




