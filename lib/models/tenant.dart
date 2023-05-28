class TenantTable {
  static const String name = 'tenant';

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

class Tenant {
  int? id;
  String? firstName;
  String? lastName;
  String? phoneNumber;

  Tenant({
    this.id,
    this.firstName,
    this.lastName,
    this.phoneNumber,
  });

  Tenant.fromMap(Map<String, dynamic> map) {
    id = map[TenantTable.id];
    firstName = map[TenantTable.firstName];
    lastName = map[TenantTable.lastName];
    phoneNumber = map[TenantTable.phoneNumber];
  }

  Map<String, dynamic> toMap() {
    return {
      TenantTable.id: id,
      TenantTable.firstName: firstName,
      TenantTable.lastName: lastName,
      TenantTable.phoneNumber: phoneNumber,
    };
  }
}
