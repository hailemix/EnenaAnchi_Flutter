import 'dart:async';

import 'package:enena_anchi/favourite_database.dart';
import 'package:enena_anchi/favourite_model.dart';

class FavouriteBloc {
  final _favouriteController =
      StreamController<List<FavouriteContent>>.broadcast();

  get favourites => _favouriteController.stream;

  dispose() {
    _favouriteController.close();
  }

  getFavourites() async {
    _favouriteController.sink.add(await DBProvider.db.getAllFavourites());
  }

  FavouriteBloc() {
    getFavourites();
  }

  delete(int id) {
    DBProvider.db.deleteFavourite(id);
    getFavourites();
  }

  add(FavouriteContent content) {
    DBProvider.db.newFavourite(content);
    getFavourites();
  }
}
