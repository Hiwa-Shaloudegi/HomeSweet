import 'dart:developer';

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

    // final maps = await db.query(UnitTable.name, orderBy: '${UnitTable.id} ASC');
    final maps = await db.rawQuery('''
  SELECT 
    ${UnitTable.name}.*,
    ${OwnerTable.name}.${OwnerTable.firstName} AS ownerFirstName,
    ${OwnerTable.name}.${OwnerTable.lastName} AS ownerLastName,
    ${OwnerTable.name}.${OwnerTable.ownerPhoneNumber} AS ownerPhoneNumber,
    ${TenantTable.name}.${TenantTable.firstName} AS tenantFirstName,
    ${TenantTable.name}.${TenantTable.lastName} AS tenantLastName,
    ${TenantTable.name}.${TenantTable.tenantPhoneNumber} AS tenantPhoneNumber
  FROM ${UnitTable.name}
  INNER JOIN ${OwnerTable.name} ON ${UnitTable.name}.${UnitTable.ownerId} = ${OwnerTable.name}.${OwnerTable.id}
  LEFT JOIN ${TenantTable.name} ON ${UnitTable.name}.${UnitTable.tenantId} = ${TenantTable.name}.${TenantTable.id}
  ORDER BY ${UnitTable.name}.${UnitTable.id} ASC
''');

    List<Unit> result = maps.map((unitMap) => Unit.fromMap(unitMap)).toList();

    return result;
  }

  static Future<Unit?> getUnitByFloorAndNumber(Unit unit) async {
    var db = await _databaseHelper.database;

    final maps = await db.query(
      UnitTable.name,
      columns: UnitTable.allColumns,
      where: '${UnitTable.floor} = ? AND ${UnitTable.number} = ?',
      whereArgs: [
        unit.floor,
        unit.number,
      ],
    );

    if (maps.isNotEmpty) {
      return Unit.fromMap(maps.first);
    } else {
      return null;
    }
  }

  static Future<int?> getId(Unit unit) async {
    var db = await _databaseHelper.database;

    final maps = await db.query(
      UnitTable.name,
      columns: [UnitTable.id],
      where:
          '${UnitTable.floor} = ? AND ${UnitTable.number} = ? AND ${UnitTable.unitPhoneNumber} = ? AND ${UnitTable.unitStatus} = ?',
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
