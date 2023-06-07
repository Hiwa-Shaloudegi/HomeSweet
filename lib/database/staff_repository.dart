import 'package:home_sweet/models/staff.dart';
import 'package:home_sweet/utils/extensions.dart';

import 'db_helper.dart';

class StaffRepository {
  StaffRepository._();

  static final DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  static Future<Staff> create(Staff staff) async {
    var db = await _databaseHelper.database;

    staff.id = await db.insert(StaffTable.name, staff.toMap());
    return staff;
  }

  static Future<Staff> read(int id) async {
    var db = await _databaseHelper.database;

    final maps = await db.query(
      StaffTable.name,
      columns: StaffTable.allColumns,
      where: '${StaffTable.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Staff.fromMap(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  static Future<List<Staff>> readAll() async {
    var db = await _databaseHelper.database;

    final maps =
        await db.query(StaffTable.name, orderBy: '${StaffTable.id} ASC');

    List<Staff> result =
        maps.map((staffMap) => Staff.fromMap(staffMap)).toList();
    return result;
  }

  static Future<int?> getId(Staff staff) async {
    var db = await _databaseHelper.database;

    final maps = await db.query(
      StaffTable.name,
      columns: [StaffTable.id],
      where: '${StaffTable.username} = ? AND ${StaffTable.password} = ?',
      whereArgs: [
        staff.username,
        staff.password,
      ],
    );

    if (maps.isNotEmpty) {
      return maps.first[StaffTable.id] as int;
    } else {
      return null;
    }
  }

  static Future<int> update(Staff staff) async {
    var db = await _databaseHelper.database;

    return db.update(
      StaffTable.name,
      staff.toMap(),
      where: '${StaffTable.id} = ?',
      whereArgs: [staff.id],
    );
  }

  static Future<int> delete(int id) async {
    var db = await _databaseHelper.database;

    return await db.delete(
      StaffTable.name,
      where: '${StaffTable.id} = ?',
      whereArgs: [id],
    );
  }

  static Future<Staff?> getLoginUser(String username, String password) async {
    var db = await _databaseHelper.database;

    var maps = await db.rawQuery("""
        SELECT *
        FROM ${StaffTable.name}
        WHERE ${StaffTable.username} = "$username" AND ${StaffTable.password} = "${password.hash}"
      """);

    if (maps.isNotEmpty) {
      return Staff.fromMap(maps.first);
    }
    return null;
  }

  static Future<bool> isUsernameTaken(String username) async {
    var db = await _databaseHelper.database;

    final result = await db.query(
      StaffTable.name,
      where: '${StaffTable.username} = ?',
      whereArgs: [username],
    );
    return result.isNotEmpty;
  }
}
