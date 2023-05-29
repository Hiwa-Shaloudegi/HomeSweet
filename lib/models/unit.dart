import 'tenant.dart';
import 'owner.dart';

class UnitTable {
  static const String name = 'unit';

  // Fields (Columns)
  static const String id = '_id';
  static const String floor = 'floor';
  static const String number = 'number';
  static const String phoneNumber = 'phoneNumber';
  static const String unitStatus = 'unitStatus';
  static const String ownerId = 'ownerId';
  static const String tenantId = 'tenantId';

  static final List<String> allColumns = [
    id,
    floor,
    number,
    phoneNumber,
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
    phoneNumber = map[UnitTable.phoneNumber];
    unitStatus = map[UnitTable.unitStatus];
    ownerId = map[UnitTable.ownerId];
    tenantId = map[UnitTable.tenantId];
    owner = Owner.fromMap(map);
    tenant = tenantId != null ? Tenant.fromMap(map) : null;
  }

  Map<String, dynamic> toMap() {
    return {
      UnitTable.id: id,
      UnitTable.floor: floor,
      UnitTable.number: number,
      UnitTable.phoneNumber: phoneNumber,
      UnitTable.unitStatus: unitStatus,
      UnitTable.ownerId: ownerId,
      UnitTable.tenantId: tenantId,
    };
  }
}
