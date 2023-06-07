import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:home_sweet/models/apartment.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/charge.dart';
import '../models/cost.dart';
import '../models/owner.dart';
import '../models/staff.dart';
import '../models/tenant.dart';
import '../models/unit.dart';
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
    log("DB Location:-----> $dbPath");
    final path = join(dbPath, databaseName);
    log("Path Of DB: $path");

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onDbCreate,
    );
  }

  Future<void> _onDbCreate(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const textNullableType = 'TEXT';
    const integerType = 'INTEGER NOT NULL';
    const integerNullableType = 'INTEGER';
    const doubleType = 'REAL NOT NULL';
    const foreignKeyUniqueType = 'INTEGER UNIQUE NOT NULL';
    const foreignKeyType = 'INTEGER NOT NULL';
    const foreignKeyNullableType = 'INTEGER UNIQUEL';
    // const boolType = 'BOOLEAN NOT NULL';
    // const dateType = 'Date NOT NULL'

    // User Table
    //!!!
//     await db.execute("""
//       CREATE TABLE ${UserTable.name} (
//       ${UserTable.id} $idType,
//       ${UserTable.username} $textType,
//       ${UserTable.password} $textType
//       )
// """);

    // Staff Table
    await db.execute(""" 
      CREATE TABLE ${StaffTable.name} (
      ${StaffTable.id} $idType,
      ${StaffTable.role} $textType,
      ${StaffTable.firstName} $textNullableType,
      ${StaffTable.lastName} $textNullableType,
      ${StaffTable.staffPhoneNumber} $textNullableType,
      ${StaffTable.startingDate} $textNullableType,
      ${StaffTable.salary} $integerNullableType,
      ${UserTable.username} $textType,
      ${UserTable.password} $textType
      )
""");

    // Apartment Table
    await db.execute(""" 
      CREATE TABLE ${ApartmentTable.name} (
      ${ApartmentTable.id} $idType,
      ${ApartmentTable.apartmentName} $textType,
      ${ApartmentTable.address} $textType,
      ${ApartmentTable.unitCharge} $doubleType,
      ${ApartmentTable.storyNumber} $integerType,
      ${ApartmentTable.unitNumber} $integerType,
      ${ApartmentTable.budget} $doubleType
      )
""");

    // Cost Table
    await db.execute(""" 
      CREATE TABLE ${CostTable.name} (
      ${CostTable.id} $idType,
      ${CostTable.title} $textType,
      ${CostTable.description} $textType,
      ${CostTable.date} $textType,
      ${CostTable.amount} $integerType,
      ${CostTable.receiptImage} $textType
      )
""");

    // Owner Table
    await db.execute(""" 
      CREATE TABLE ${OwnerTable.name} (
      ${OwnerTable.id} $idType,
      ${OwnerTable.firstName} $textType,
      ${OwnerTable.lastName} $textType,
      ${OwnerTable.ownerPhoneNumber} $textType
      )
""");

    // Tenant Table
    await db.execute(""" 
      CREATE TABLE ${TenantTable.name} (
      ${TenantTable.id} $idType,
      ${TenantTable.firstName} $textType,
      ${TenantTable.lastName} $textType,
      ${TenantTable.tenantPhoneNumber} $textType
      )
""");

    // Unit Table
    await db.execute(""" 
      CREATE TABLE ${UnitTable.name} (
      ${UnitTable.id} $idType,
      ${UnitTable.floor} $integerType,
      ${UnitTable.number} $integerType,
      ${UnitTable.unitPhoneNumber} $textType,
      ${UnitTable.unitStatus} $textType,
      ${UnitTable.ownerId} $foreignKeyUniqueType,
      ${UnitTable.tenantId} $foreignKeyNullableType,
      FOREIGN KEY (${UnitTable.ownerId}) REFERENCES ${OwnerTable.name} (${OwnerTable.id}),
      FOREIGN KEY (${UnitTable.tenantId}) REFERENCES ${TenantTable.name} (${TenantTable.id}),
      UNIQUE (${UnitTable.floor}, ${UnitTable.number})
      )
""");

    // Charge Table
    await db.execute(""" 
      CREATE TABLE ${ChargeTable.name} (
      ${ChargeTable.id} $idType,
      ${ChargeTable.title} $textType,
      ${ChargeTable.date} $textType,
      ${ChargeTable.amount} $integerType,
      ${ChargeTable.unitId} $foreignKeyType
      )
""");

    // TODO: Create other tables.
  }
}
