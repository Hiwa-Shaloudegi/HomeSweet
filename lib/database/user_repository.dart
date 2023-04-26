import 'package:home_sweet/database/db_helper.dart';

import '../models/user.dart';

class UserRepository {
  UserRepository._();

  static final DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  static Future<User> create(User user) async {
    var db = await _databaseHelper.database;

    user.id = await db.insert(UserTable.name, user.toMap());
    return user;
  }

  static Future<User> read(int id) async {
    var db = await _databaseHelper.database;

    final maps = await db.query(
      UserTable.name,
      columns: UserTable.allColumns,
      where: '${UserTable.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return User.fromMap(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  static Future<List<User>> readAll() async {
    var db = await _databaseHelper.database;

    final maps = await db.query(UserTable.name, orderBy: '${UserTable.id} ASC');

    List<User> result = maps.map((userMap) => User.fromMap(userMap)).toList();
    return result;
  }

  static Future<int> update(User user) async {
    var db = await _databaseHelper.database;

    return db.update(
      UserTable.name,
      user.toMap(),
      where: '${UserTable.id} = ?',
      whereArgs: [user.id],
    );
  }

  static Future<int> delete(int id) async {
    var db = await _databaseHelper.database;

    return await db.delete(
      UserTable.name,
      where: '${UserTable.id} = ?',
      whereArgs: [id],
    );
  }
}
