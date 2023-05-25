class UnitTable {
  static const String name = 'unit';

  // Fields (Columns)
  static const String id = '_id';
  static const String floor = 'floor';
  static const String number = 'number';
  static const String phoneNumber = 'phoneNumber';
  static const String unitStatus = 'unitStatus';

  static final List<String> allColumns = [
    id,
    floor,
    number,
    phoneNumber,
    unitStatus,
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

  Unit({
    this.id,
    this.floor,
    this.number,
    this.phoneNumber,
    this.unitStatus,
  });

  Unit.fromMap(Map<String, dynamic> map) {
    id = map[UnitTable.id];
    floor = map[UnitTable.floor];
    number = map[UnitTable.number];
    phoneNumber = map[UnitTable.phoneNumber];
    unitStatus = map[UnitTable.unitStatus];
  }

  Map<String, dynamic> toMap() {
    return {
      UnitTable.id: id,
      UnitTable.floor: floor,
      UnitTable.number: number,
      UnitTable.phoneNumber: phoneNumber,
      UnitTable.unitStatus: unitStatus,
    };
  }
}
