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
    id = map[UserFields.id];
    username = map[UserFields.username];
    password = map[UserFields.password];
  }

  Map<String, dynamic> toMap() {
    return {
      UserFields.id: id,
      UserFields.username: username,
      UserFields.password: password,
    };
  }
}

class UserFields {
  // Table
  static const String tableName = 'user';

  // Fields (Columns)
  static const String id = '_id';
  static const String username = 'username';
  static const String password = 'password';
}
