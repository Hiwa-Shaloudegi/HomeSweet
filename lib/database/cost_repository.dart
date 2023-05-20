import 'package:home_sweet/models/cost.dart';

import 'db_helper.dart';

class CostRepository {
  CostRepository._();

  static final DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  static Future<Cost> create(Cost cost) async {
    var db = await _databaseHelper.database;

    cost.id = await db.insert(CostTable.name, cost.toMap());
    return cost;
  }

  static Future<Cost?> read(int id) async {
    var db = await _databaseHelper.database;

    final maps = await db.query(
      CostTable.name,
      columns: CostTable.allColumns,
      where: '${CostTable.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Cost.fromMap(maps.first);
    } else {
      //TODO: should return null OR throw exception ?
      // throw Exception('ID $id not found');
      return null;
    }
  }

  static Future<List<Cost>> readAll() async {
    var db = await _databaseHelper.database;

    final maps = await db.query(CostTable.name, orderBy: '${CostTable.id} ASC');

    List<Cost> result = maps.map((costMap) => Cost.fromMap(costMap)).toList();
    return result;
  }

  static Future<int> update(Cost cost) async {
    var db = await _databaseHelper.database;

    return db.update(
      CostTable.name,
      cost.toMap(),
      where: '${CostTable.id} = ?',
      whereArgs: [cost.id],
    );
  }

  static Future<int> delete(int id) async {
    var db = await _databaseHelper.database;

    return await db.delete(
      CostTable.name,
      where: '${CostTable.id} = ?',
      whereArgs: [id],
    );
  }
}