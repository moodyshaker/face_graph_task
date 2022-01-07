import 'dart:io';

import 'package:face_graph_task/model/database_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class Storage {
  static final Storage instance = Storage._instance();
  static const String tableName = 'face_graph_table';
  static const String id = '_id';
  static const String title = 'title';
  static const String date = 'date';
  static const String picture = 'picture';
  static const String description = 'description';
  static const String status = 'status';
  static const int version = 1;
  static Database _db;

  Storage._instance();

  Future<Database> get db async =>
      _db ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, tableName);
    Database db =
    await openDatabase(path, onCreate: _createDB, version: version);
    return db;
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute(
      """
      CREATE TABLE $tableName(
      $id INTEGER PRIMARY KEY AUTOINCREMENT,
      $title TEXT NOT NULL,
      $date TEXT NOT NULL,
      $picture TEXT NOT NULL,
      $description TEXT NOT NULL,
      $status INTEGER NOT NULL)
    """,
    );
  }

  Future<void> insert(DatabaseModel item) async {
    Database database = await db;
    await database.insert(
      tableName,
      item.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> update(DatabaseModel item) async {
    Database database = await db;
    await database.update(
      tableName,
      item.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
      where: "_id = ?",
      whereArgs: [item.id],
    );
  }

  Future<void> deleteAll() async {
    Database database = await db;
    database.rawDelete('DELETE FROM $tableName');
  }

  Future<void> delete(DatabaseModel item) async {
    Database database = await db;
    await database.delete(
      tableName,
      where: '_id = ?',
      whereArgs: [item.id],
    );
  }

  Future<List<DatabaseModel>> getAllNotes() async {
    Database database = await db;
    List<Map<String, dynamic>> data = await database.query(
      tableName,
    );
    List<DatabaseModel> models = [];
    models = data.map((e)=> DatabaseModel.fromMap(e));
    return models;
  }

  Future<void> closeDB() async {
    Database database = await db;
    await database.close();
    _db = null;
  }
}
