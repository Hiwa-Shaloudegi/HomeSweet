import 'package:home_sweet/models/cost.dart';
import 'package:home_sweet/models/owner.dart';

import 'db_helper.dart';

class OwnerRepository {
  OwnerRepository._();

  static final DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  static Future<Owner> create(Owner owner) async {
    var db = await _databaseHelper.database;

    owner.id = await db.insert(OwnerTable.name, owner.toMap());
    return owner;
  }

  static Future<Owner?> read(int id) async {
    var db = await _databaseHelper.database;

    final maps = await db.query(
      OwnerTable.name,
      columns: OwnerTable.allColumns,
      where: '${OwnerTable.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Owner.fromMap(maps.first);
    } else {
      //TODO: should return null OR throw exception ?
      // throw Exception('ID $id not found');
      return null;
    }
  }

  static Future<List<Owner>> readAll() async {
    var db = await _databaseHelper.database;

    final maps =
        await db.query(OwnerTable.name, orderBy: '${OwnerTable.id} ASC');

    List<Owner> result =
        maps.map((ownerMap) => Owner.fromMap(ownerMap)).toList();
    return result;
  }

  static Future<int?> getId(Owner owner) async {
    var db = await _databaseHelper.database;

    final maps = await db.query(
      OwnerTable.name,
      columns: [OwnerTable.id],
      where:
          '${OwnerTable.firstName} = ? AND ${OwnerTable.lastName} = ? AND ${OwnerTable.ownerPhoneNumber} = ?',
      whereArgs: [
        owner.firstName,
        owner.lastName,
        owner.ownerPhoneNumber,
      ],
    );

    if (maps.isNotEmpty) {
      return maps.first[OwnerTable.id] as int;
    } else {
      return null;
    }
  }

  static Future<int> update(Owner owner) async {
    var db = await _databaseHelper.database;

    var a = await db.update(
      OwnerTable.name,
      owner.toMap(),
      where: '${OwnerTable.id} = ?',
      whereArgs: [owner.id],
    );

    return a;
  }

  static Future<int> delete(int id) async {
    var db = await _databaseHelper.database;

    return await db.delete(
      OwnerTable.name,
      where: '${OwnerTable.id} = ?',
      whereArgs: [id],
    );
  }
}
