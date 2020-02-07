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
          child: Container(
            decoration: BoxDecoration(
              color: CupertinoColors.lightBackgroundGray,
            ),
            child: StreamBuilder<List<FavouriteContent>>(
              stream: bloc.favourites,
              builder: (BuildContext context,
                  AsyncSnapshot<List<FavouriteContent>> snapshot) {
                if (snapshot.hasData) {
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
                                          fontWeight: FontWeight.bold),
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

                else
                  return Center(
                      child: Flex(
                          direction: Axis.vertical,
                          children: [
                            Icon(Icons.announcement),
                            Text('No Favourites Added')
                          ]));
              },
            ),
          )
      ),
    );
  }
}
