import 'package:home_sweet/models/cost.dart';

import '../models/charge.dart';
import 'db_helper.dart';

class ChargeRepository {
  ChargeRepository._();

  static final DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  static Future<Charge> create(Charge charge) async {
    var db = await _databaseHelper.database;

    charge.id = await db.insert(ChargeTable.name, charge.toMap());
    return charge;
  }

  static Future<Charge?> read(int id) async {
    var db = await _databaseHelper.database;

    final maps = await db.query(
      ChargeTable.name,
      columns: ChargeTable.allColumns,
      where: '${ChargeTable.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Charge.fromMap(maps.first);
    } else {
      return null;
    }
  }

  static Future<List<Charge>> readAll() async {
    var db = await _databaseHelper.database;

    final maps =
        await db.query(ChargeTable.name, orderBy: '${ChargeTable.id} ASC');

    List<Charge> result =
        maps.map((chargeMap) => Charge.fromMap(chargeMap)).toList();
    return result;
  }

  static Future<int?> getId(Charge charge) async {
    var db = await _databaseHelper.database;

    final maps = await db.query(
      ChargeTable.name,
      columns: [ChargeTable.id],
      where:
          '${ChargeTable.title} = ? AND ${CostTable.date} = ? AND ${CostTable.amount} = ?AND ${ChargeTable.unitId} = ?',
      whereArgs: [
        charge.title,
        charge.date,
        charge.amount,
        charge.unitId,
      ],
    );

    if (maps.isNotEmpty) {
      return maps.first[ChargeTable.id] as int;
    } else {
      return null;
    }
  }

  static Future<int> update(Charge charge) async {
    var db = await _databaseHelper.database;

    var a = await db.update(
      ChargeTable.name,
      charge.toMap(),
      where: '${ChargeTable.id} = ?',
      whereArgs: [charge.id],
    );

    return a;
  }

  static Future<int> delete(int id) async {
    var db = await _databaseHelper.database;

    return await db.delete(
      ChargeTable.name,
      where: '${ChargeTable.id} = ?',
      whereArgs: [id],
    );
  }
}
