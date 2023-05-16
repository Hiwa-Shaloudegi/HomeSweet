class ApartmentTable {
  static const String name = 'apartment';

  // Fields (Columns)
  static const String id = '_id';
  static const String apartmentName = 'apartmentName';
  static const String address = 'address';
  static const String unitCharge = 'unitCharge';
  static const String storyNumber = 'storyNumber';
  static const String unitNumber = 'unitNumber';
  static const String budget = 'budget';

  static final List<String> allColumns = [
    id,
    apartmentName,
    address,
    unitCharge,
    storyNumber,
    unitNumber,
    budget,
  ];
}

class Apartment {
  int? id;
  String? apartmentName;
  String? address;
  double? unitCharge;
  int? storyNumber;
  int? unitNumber;
  double? budget;

  Apartment({
    this.id,
    this.apartmentName,
    this.address,
    this.unitCharge,
    this.storyNumber,
    this.unitNumber,
    this.budget,
  });

  Apartment.fromMap(Map<String, dynamic> map) {
    id = map[ApartmentTable.id];
    apartmentName = map[ApartmentTable.apartmentName];
    address = map[ApartmentTable.address];
    unitCharge = map[ApartmentTable.unitCharge];
    storyNumber = map[ApartmentTable.storyNumber];
    unitNumber = map[ApartmentTable.unitNumber];
    budget = map[ApartmentTable.budget];
  }

  Map<String, dynamic> toMap() {
    return {
      ApartmentTable.id: id,
      ApartmentTable.apartmentName: apartmentName,
      ApartmentTable.address: address,
      ApartmentTable.unitCharge: unitCharge,
      ApartmentTable.storyNumber: storyNumber,
      ApartmentTable.unitNumber: unitNumber,
      ApartmentTable.budget: budget,
    };
  }
}
