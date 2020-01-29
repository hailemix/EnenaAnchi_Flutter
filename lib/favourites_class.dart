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
                  child: Icon(CupertinoIcons.back), onPressed: () {
                Navigator.pop(context);
              })
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
                            Text(content.id.toString()),
                            Expanded(
                              flex: 1,
                              child: Padding(padding: EdgeInsets.all(20),
                                child: SelectableText(
                                  content.favouriteContent,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                  scrollPhysics: ClampingScrollPhysics(),
                                ),),
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
          )
      ),
    );
  }
}
