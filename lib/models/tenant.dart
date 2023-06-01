class TenantTable {
  static const String name = 'tenant';

  // Fields (Columns)
  static const String id = '_id';
  static const String firstName = 'firstName';
  static const String lastName = 'lastName';
  static const String tenantPhoneNumber = 'tenantPhoneNumber';

  static final List<String> allColumns = [
    id,
    firstName,
    lastName,
    tenantPhoneNumber,
  ];
}

class Tenant {
  int? id;
  String? firstName;
  String? lastName;
  String? tenantPhoneNumber;

  Tenant({
    this.id,
    this.firstName,
    this.lastName,
    this.tenantPhoneNumber,
  });

  Tenant.fromMap(Map<String, dynamic> map) {
    id = map[TenantTable.id];
    firstName = map[TenantTable.firstName];
    lastName = map[TenantTable.lastName];
    tenantPhoneNumber = map[TenantTable.tenantPhoneNumber];
  }

  Map<String, dynamic> toMap() {
    return {
      TenantTable.id: id,
      TenantTable.firstName: firstName,
      TenantTable.lastName: lastName,
      TenantTable.tenantPhoneNumber: tenantPhoneNumber,
    };
  }
}
