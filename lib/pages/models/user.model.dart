import 'dart:convert';

class User {
  String user;
  String password;
  int id;
  List modelData;

  User({
    required this.user,
    required this.id,
    required this.password,
    required this.modelData,
  });

  static User fromMap(Map<String, dynamic> user) {
    return new User(
        user: user['user'],
        password: user['password'],
        modelData: jsonDecode(user['modelData']),
        id: int.parse(user['id']));
  }

  toMap() {
    return {
      'user': user,
      'password': password,
      'id': id,
      'model_data': jsonEncode(modelData),
    };
  }
}
