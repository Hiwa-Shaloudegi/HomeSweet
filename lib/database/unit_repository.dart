import '../models/owner.dart';
import '../models/tenant.dart';
import '../models/unit.dart';
import 'db_helper.dart';

class UnitRepository {
  UnitRepository._();

  static final DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  static Future<Unit> create(Unit unit) async {
    var db = await _databaseHelper.database;

    unit.id = await db.insert(UnitTable.name, unit.toMap());
    return unit;
  }

  static Future<Unit?> read(int id) async {
    var db = await _databaseHelper.database;

    final maps = await db.query(
      UnitTable.name,
      columns: UnitTable.allColumns,
      where: '${UnitTable.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Unit.fromMap(maps.first);
    } else {
      return null;
    }
  }

  static Future<List<Unit>> readAll() async {
    var db = await _databaseHelper.database;

    //! start
    final maps = await db.query(UnitTable.name, orderBy: '${UnitTable.id} ASC');

    List<Unit> result = maps.map((unitMap) => Unit.fromMap(unitMap)).toList();
    return result;
    //! end
    // final maps = await db.rawQuery('''
    //   SELECT ${UnitTable.allColumns}, ${OwnerTable.allColumns}, ${TenantTable.allColumns}
    //   FROM ${UnitTable.name}
    //   LEFT JOIN ${OwnerTable.name} ON ${UnitTable.ownerId} = ${OwnerTable.id}
    //   LEFT JOIN ${TenantTable.name} ON ${UnitTable.tenantId} = ${TenantTable.id}
    //   ORDER BY ${UnitTable.id} ASC
    // ''');

    // List<Unit> result = maps.map((unitMap) {
    //   final unit = Unit.fromMap(unitMap);
    //   unit.owner = Owner.fromMap(unitMap);
    //   unit.tenant = Tenant.fromMap(unitMap);
    //   return unit;
    // }).toList();

    // return result;
  }

  static Future<int?> getId(Unit unit) async {
    var db = await _databaseHelper.database;

    final maps = await db.query(
      UnitTable.name,
      columns: [UnitTable.id],
      where:
          '${UnitTable.floor} = ? AND ${UnitTable.number} = ? AND ${UnitTable.phoneNumber} = ? AND ${UnitTable.unitStatus} = ?',
      whereArgs: [
        unit.floor,
        unit.number,
        unit.phoneNumber,
        unit.unitStatus, //TODO: maybe --> toString()
      ],
    );

    if (maps.isNotEmpty) {
      return maps.first[UnitTable.id] as int;
    } else {
      return null;
    }
  }

  static Future<int> update(Unit unit) async {
    var db = await _databaseHelper.database;

    var a = await db.update(
      UnitTable.name,
      unit.toMap(),
      where: '${UnitTable.id} = ?',
      whereArgs: [unit.id],
    );

    return a; //TODO: delete this
  }

  static Future<int> delete(int id) async {
    var db = await _databaseHelper.database;

    return await db.delete(
      UnitTable.name,
      where: '${UnitTable.id} = ?',
      whereArgs: [id],
    );
  }
}
