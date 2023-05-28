class OwnerTable {
  static const String name = 'owner';

  // Fields (Columns)
  static const String id = '_id';
  static const String firstName = 'firstName';
  static const String lastName = 'lastName';
  static const String phoneNumber = 'phoneNumber';

  static final List<String> allColumns = [
    id,
    firstName,
    lastName,
    phoneNumber,
  ];
}

class Owner {
  int? id;
  String? firstName;
  String? lastName;
  String? phoneNumber;

  Owner({
    this.id,
    this.firstName,
    this.lastName,
    this.phoneNumber,
  });

  Owner.fromMap(Map<String, dynamic> map) {
    id = map[OwnerTable.id];
    firstName = map[OwnerTable.firstName];
    lastName = map[OwnerTable.lastName];
    phoneNumber = map[OwnerTable.phoneNumber];
  }

  Map<String, dynamic> toMap() {
    return {
      OwnerTable.id: id,
      OwnerTable.firstName: firstName,
      OwnerTable.lastName: lastName,
      OwnerTable.phoneNumber: phoneNumber,
    };
  }
}
