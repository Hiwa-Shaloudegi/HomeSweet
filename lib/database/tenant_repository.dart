import 'package:sweet_home/models/tenant.dart';

import 'db_helper.dart';

class TenantRepository {
  TenantRepository._();

  static final DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  static Future<Tenant> create(Tenant tenant) async {
    var db = await _databaseHelper.database;

    tenant.id = await db.insert(TenantTable.name, tenant.toMap());
    return tenant;
  }

  static Future<Tenant?> read(int id) async {
    var db = await _databaseHelper.database;

    final maps = await db.query(
      TenantTable.name,
      columns: TenantTable.allColumns,
      where: '${TenantTable.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Tenant.fromMap(maps.first);
    } else {
      return null;
    }
  }

  static Future<List<Tenant>> readAll() async {
    var db = await _databaseHelper.database;

    final maps =
        await db.query(TenantTable.name, orderBy: '${TenantTable.id} ASC');

    List<Tenant> result =
        maps.map((tenantMap) => Tenant.fromMap(tenantMap)).toList();
    return result;
  }

  static Future<int?> getId(Tenant tenant) async {
    var db = await _databaseHelper.database;

    final maps = await db.query(
      TenantTable.name,
      columns: [TenantTable.id],
      where:
          '${TenantTable.firstName} = ? AND ${TenantTable.lastName} = ? AND ${TenantTable.tenantPhoneNumber} = ?',
      whereArgs: [
        tenant.firstName,
        tenant.lastName,
        tenant.tenantPhoneNumber,
      ],
    );

    if (maps.isNotEmpty) {
      return maps.first[TenantTable.id] as int;
    } else {
      return null;
    }
  }

  static Future<int> update(Tenant owner) async {
    var db = await _databaseHelper.database;

    var a = await db.update(
      TenantTable.name,
      owner.toMap(),
      where: '${TenantTable.id} = ?',
      whereArgs: [owner.id],
    );

    return a;
  }

  static Future<int> delete(int id) async {
    var db = await _databaseHelper.database;

    return await db.delete(
      TenantTable.name,
      where: '${TenantTable.id} = ?',
      whereArgs: [id],
    );
  }
}
