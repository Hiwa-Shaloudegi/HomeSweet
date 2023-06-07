class StaffTable {
  static const String name = 'staff';

  // Fields (Columns)
  static const String id = '_id';
  static const String role = 'role';
  static const String firstName = 'firstName';
  static const String lastName = 'lastName';
  static const String staffPhoneNumber = 'staffPhoneNumber';
  static const String startingDate = 'startingDate';
  static const String salary = 'salary';
  static const String username = 'username';
  static const String password = 'password';

  static final List<String> allColumns = [
    id,
    role,
    firstName,
    lastName,
    staffPhoneNumber,
    startingDate,
    salary,
    username,
    password,
  ];
}

class Staff {
  int? id;
  String? role;
  String? firstName;
  String? lastName;
  String? staffPhoneNumber;
  String? startingDate;
  int? salary;
  String? username;
  String? password;

  Staff({
    this.id,
    this.role,
    this.firstName,
    this.lastName,
    this.staffPhoneNumber,
    this.startingDate,
    this.salary,
    this.username,
    this.password,
  });

  Staff.fromMap(Map<String, dynamic> map) {
    id = map[StaffTable.id];
    role = map[StaffTable.role];
    firstName = map[StaffTable.firstName];
    lastName = map[StaffTable.lastName];
    staffPhoneNumber = map[StaffTable.staffPhoneNumber];
    startingDate = map[StaffTable.startingDate];
    salary = map[StaffTable.salary];
    username = map[StaffTable.username];
    password = map[StaffTable.password];
  }

  Map<String, dynamic> toMap() {
    return {
      StaffTable.id: id,
      StaffTable.role: role,
      StaffTable.firstName: firstName,
      StaffTable.lastName: lastName,
      StaffTable.staffPhoneNumber: staffPhoneNumber,
      StaffTable.startingDate: startingDate,
      StaffTable.salary: salary,
      StaffTable.username: username,
      StaffTable.password: password,
    };
  }
}
