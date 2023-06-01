class OwnerTable {
  static const String name = 'owner';

  // Fields (Columns)
  static const String id = '_id'; //TODO
  static const String firstName =
      'firstName'; //TODO: ownerFirstName --> it should be like the map.
  static const String lastName = 'lastName'; //TODO
  static const String ownerPhoneNumber = 'ownerPhoneNumber';

  static final List<String> allColumns = [
    id,
    firstName,
    lastName,
    ownerPhoneNumber,
  ];
}

class Owner {
  int? id;
  String? firstName;
  String? lastName;
  String? ownerPhoneNumber;

  Owner({
    this.id,
    this.firstName,
    this.lastName,
    this.ownerPhoneNumber,
  });

  Owner.fromMap(Map<String, dynamic> map) {
    id = map[OwnerTable.id];
    firstName = map[OwnerTable.firstName];
    lastName = map[OwnerTable.lastName];
    ownerPhoneNumber = map[OwnerTable.ownerPhoneNumber];
  }

  Map<String, dynamic> toMap() {
    return {
      OwnerTable.id: id,
      OwnerTable.firstName: firstName,
      OwnerTable.lastName: lastName,
      OwnerTable.ownerPhoneNumber: ownerPhoneNumber,
    };
  }
}
