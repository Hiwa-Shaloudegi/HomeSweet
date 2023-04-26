import 'package:flutter/material.dart';
import 'package:home_sweet/utils/extensions.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/user.dart';

class DatabaseHelper {
  DatabaseHelper._init();
  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  // DB name
  static const String databaseName = 'ams.db';

  // DB Functions
  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    } else {
      _database = await _initDB();
      return _database!;
    }
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    print("DB Location:-----> $dbPath");
    final path = join(dbPath, databaseName);
    debugPrint("Path Of DB: $path");

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onDbCreate,
    );
  }

  Future<void> _onDbCreate(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';

    await db.execute(""" 
      CREATE TABLE ${UserTable.name} (
      ${UserTable.id} $idType,
      ${UserTable.username} $textType,
      ${UserTable.password} $textType
      )
""");

    // TODO: Create other tables.
  }

  Future<User> createUser(User user) async {
    var db = await instance.database;

    user.id = await db.insert(UserTable.name, user.toMap());
    return user;
  }

  // Future<User?> getUser(int id) async {
  //   var db = _db;

  //   List<Map<String, dynamic>> maps = await db!.query(
  //     UserFields.tableName,
  //     columns: [UserFields.id, UserFields.username, UserFields.password],
  //     where: '${UserFields.id} = ?',
  //     whereArgs: [id],
  //   );
  //   if (maps.length > 0) {
  //     return User.fromMap(maps.first);
  //   }
  //   return null;
  // }

  Future<User?> getLoginUser(String username, String password) async {
    var db = await instance.database;

    var maps = await db.rawQuery("""
        SELECT *
        FROM ${UserTable.name}
        WHERE ${UserTable.username} = "$username" AND ${UserTable.password} = "${password.hash()}"
      """);

    if (maps.isNotEmpty) {
      print(User.fromMap(maps.first).toString());
      return User.fromMap(maps.first);
    }
    return null;
  }

  Future<User?> getUserByUsername(String username) async {
    var db = await instance.database;

    var maps = await db.rawQuery("""
        SELECT *
        FROM ${UserTable.name}
        WHERE ${UserTable.username} = "$username"
      """);

    if (maps.isNotEmpty) {
      return User.fromMap(maps.first);
    }
    return null;
  }
}
