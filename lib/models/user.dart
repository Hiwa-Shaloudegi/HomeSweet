class UserTable {
  static const String name = 'user';

  // Fields (Columns)
  static const String id = '_id';
  static const String username = 'username';
  static const String password = 'password';

  static final List<String> allColumns = [id, username, password];
}

class User {
  int? id;
  String? username;
  String? password;

  User({
    this.id,
    this.username,
    this.password,
  });

  User.fromMap(Map<String, dynamic> map) {
    id = map[UserTable.id];
    username = map[UserTable.username];
    password = map[UserTable.password];
  }

  Map<String, dynamic> toMap() {
    return {
      UserTable.id: id,
      UserTable.username: username,
      UserTable.password: password,
    };
  }
}
