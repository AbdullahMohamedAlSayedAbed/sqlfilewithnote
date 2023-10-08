import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqlDb {
  static Database? _db;
  Future<Database?> get db async {
    if (_db == null) {
      _db = await intialDb();
      return _db;
    } else {
      return _db;
    }
  }

  intialDb() async {
    var databasePath = await getDatabasesPath();
    String path = join(databasePath, "abdullah.db");
    Database myDb = await openDatabase(path, version: 1, onUpgrade: _onUpgrade,
        onCreate: (Database db, int version) async {
      await db.execute('''
          CREATE TABLE "notes" ("id" INTEGER PRIMARY KEY AUTOINCREMENT,
          "title" TEXT NOT NULL,
          "note" TEXT NOT NULL)
          ''');
    });
    return myDb;
  }

  _onUpgrade(Database db, int oldVersion, int newVersion) {
    print("------_onUpgrade------");
  }

  readDate(String sql) async {
    Database? mydb = await db;
    List<Map<String, Object?>> response = await mydb!.rawQuery(sql);
    return response;
  }

  insertDate(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawInsert(sql);
    return response;
  }

  deleteDate(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawDelete(sql);
    return response;
  }

  updateDate(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawUpdate(sql);
    return response;
  }

  myDeleteDatabase() async {
    var databasePath = await getDatabasesPath();
    String path = join(databasePath, "abdullah.db");
    await deleteDatabase(path);
  }
}
