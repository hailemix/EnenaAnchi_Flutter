import 'dart:io';
import 'package:enena_anchi/favourite_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initDatabase();
    return _database;
  }

  initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "favouriteDB.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE FavouriteContent ("
          "id INTEGER PRIMARY KEY,"
          "favourite_content TEXT"
          ")");
    });
  }

  newFavourite(FavouriteContent newFavourite) async {
    final db = await database;
    var table =
        await db.rawQuery("SELECT MAX(id)+1 as id FROM FavouriteContent");
    int id = table.first["id"];
    var raw = await db.rawInsert(
        "INSERT Into FavouriteContent (id,favourite_content)"
        "VALUES (?,?)",
        [id, newFavourite.favouriteContent]);
    return raw;
  }

  updateFavourite(FavouriteContent newFavourite) async {
    final db = await database;
    var res = await db.update("FavouriteContent", newFavourite.toMap(),
        where: "id = ?", whereArgs: [newFavourite.id]);
    return res;
  }

  getFavourite(int id) async {
    final db = await database;
    var res =
        await db.query("FavouriteContent", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? FavouriteContent.fromMap(res.first) : null;
  }

  Future<List<FavouriteContent>> getAllFavourites() async {
    final db = await database;
    var res = await db.query("FavouriteContent");
    List<FavouriteContent> list = res.isNotEmpty
        ? res.map((c) => FavouriteContent.fromMap(c)).toList()
        : [];
    return list;
  }

  deleteFavourite(int id) async {
    final db = await database;
    return db.delete("FavouriteContent", where: "id = ?", whereArgs: [id]);
  }

  deleteAllFavourite(int id) async {
    final db = await database;
    db.rawDelete("Delete * from FavouriteContent");
  }
}
