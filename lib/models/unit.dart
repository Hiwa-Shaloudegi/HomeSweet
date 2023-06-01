import 'dart:developer';

import 'tenant.dart';
import 'owner.dart';

class UnitTable {
  static const String name = 'unit';

  // Fields (Columns)
  static const String id = '_id';
  static const String floor = 'floor';
  static const String number = 'number';
  static const String unitPhoneNumber = 'unitPhoneNumber';
  static const String unitStatus = 'unitStatus';
  static const String ownerId = 'ownerId';
  static const String tenantId = 'tenantId';

  static final List<String> allColumns = [
    id,
    floor,
    number,
    unitPhoneNumber,
    unitStatus,
    ownerId,
    tenantId,
  ];
}

enum UnitStatus {
  owner,
  tenant,
  empty,
}

class Unit {
  int? id;
  int? floor;
  int? number;
  String? phoneNumber;
  String? unitStatus;
  int? ownerId;
  int? tenantId;
  Owner? owner;
  Tenant? tenant;

  Unit({
    this.id,
    this.floor,
    this.number,
    this.phoneNumber,
    this.unitStatus,
    this.ownerId,
    this.tenantId,
    this.owner,
    this.tenant,
  });

  Unit.fromMap(Map<String, dynamic> map) {
    id = map[UnitTable.id];
    floor = map[UnitTable.floor];
    number = map[UnitTable.number];
    phoneNumber = map[UnitTable.unitPhoneNumber];
    unitStatus = map[UnitTable.unitStatus];
    ownerId = map[UnitTable.ownerId];
    tenantId = map[UnitTable.tenantId];
    // owner = Owner.fromMap(map);
    owner = Owner(
      id: map['ownerId'], //map[OwnerTable.id],
      firstName: map['ownerFirstName'], //map[OwnerTable.firstName],
      lastName: map['ownerLastName'], //map[OwnerTable.lastName],
      ownerPhoneNumber:
          map['ownerPhoneNumber'], // map[OwnerTable.ownerPhoneNumber],
    );
    // Owner.fromMap({
    //   OwnerTable.id: map[OwnerTable.id],
    //   OwnerTable.firstName: map[OwnerTable.firstName],
    //   OwnerTable.lastName: map[OwnerTable.lastName],
    //   OwnerTable.ownerPhoneNumber: map[OwnerTable.ownerPhoneNumber],
    // });
    // tenant = tenantId != null ? Tenant.fromMap(map) : null;
    tenant = tenantId != null
        ? Tenant(
            id: map['tenantId'], //map[TenantTable.id],
            firstName: map['tenantFirstName'], //map[TenantTable.firstName],
            lastName: map['tenantLastName'], //map[TenantTable.lastName],
            tenantPhoneNumber:
                map['tenantPhoneNumber'], //map[TenantTable.tenantPhoneNumber],
          )
        : null;
  }

  Map<String, dynamic> toMap() {
    return {
      UnitTable.id: id,
      UnitTable.floor: floor,
      UnitTable.number: number,
      UnitTable.unitPhoneNumber: phoneNumber,
      UnitTable.unitStatus: unitStatus,
      UnitTable.ownerId: ownerId,
      UnitTable.tenantId: tenantId,
    };
  }

  @override
  String toString() {
    log('''
      id$id,\t
      phoneNumber: $phoneNumber,\t
      unitStatus: $unitStatus,\n
      ownerId: $ownerId,\t
      ownerName: ${owner!.firstName} ${owner!.lastName},\t
      ownerPhone: ${owner!.ownerPhoneNumber}, \n
      tenantId: $tenantId,\t
      tenant: ${tenant?.firstName} ${tenant?.lastName},\t
      tenantPhone: ${tenant?.tenantPhoneNumber}, \n

    ''');
    return super.toString();
  }
}
