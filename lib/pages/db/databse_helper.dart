import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/user.model.dart';

class Prod {
  int id;
  String title;
  String description;
  double price;
  List images;

  Prod(
      {required this.id,
      required this.title,
      required this.description,
      required this.price,
      required this.images});

  factory Prod.fromJson(Map<String, dynamic> json) {
    return Prod(
        id: int.parse(json['id']),
        title: json['title'],
        description: json['description'],
        price: double.parse(json['price']),
        images: json['images']);
  }
}

class MyModel {
  String id;
  String user;
  String password;
  String modeldata;
  String? FirstName;
  String? LastName;
  int? PhoneNumber;
  String? Email;

  MyModel(
      {required this.id,
      required this.user,
      required this.password,
      required this.modeldata});

  factory MyModel.fromJson(Map<String, dynamic> json) {
    return MyModel(
        id: json['id'],
        user: json['username'],
        password: json['password'],
        modeldata: json['modeldata']);
  }
}

Future<int> inserting(MyModel user) async {
  final url = "https://flutterprogayya.000webhostapp.com/adduser.php";
  http.Response reponsa = await http.post(Uri.parse(url),
      body: jsonEncode({
        "username": user.user,
        "password": user.password,
        "modeldata": user.modeldata
      }));
  if (reponsa.statusCode == 200) {
    print('yes');
    print(reponsa.body);
    return 1;
  } else {
    print('no');
    return 0;
  }
}

Future<List<Prod>> fetch() async {
  final url = "https://flutterprogayya.000webhostapp.com/getposts.php";
  http.Response reponsa = await http.get(
    Uri.parse(url),
  );
  final List<dynamic> posts = json.decode(reponsa.body);
  print(posts);
  final final_list = posts.map((json) => Prod.fromJson(json)).toList();
  print(final_list);
  return final_list;
}

Future<MyModel?> fetchuser(id) async {
  final url = "https://flutterprogayya.000webhostapp.com/getuser.php?id=" + id;
  print('here');
  http.Response reponsa = await http.get(
    Uri.parse(url),
  );
  final usera = json.decode(reponsa.body);
  final final_list = MyModel.fromJson(usera);
  print(final_list);
  return final_list;
}

Future<int> insertproduct(Prod prod) async {
  final url = "https://flutterprogayya.000webhostapp.com/addproduct.php";
  http.Response reponsa = await http.post(Uri.parse(url),
      body: jsonEncode({
        "title": prod.title,
        "description": prod.description,
        "price": prod.price,
        "images": jsonEncode(prod.images)
      }));
  if (reponsa.statusCode == 200) {
    print('yes');
    print(reponsa.body);
    return 1;
  } else {
    print('no');
    return 0;
  }
}

Future<int> updateuser(
    MyModel user, String new_password, String confirm_password) async {
  final url = "https://flutterprogayya.000webhostapp.com/updateprofile.php";
  http.Response reponsa = await http.post(Uri.parse(url),
      body: jsonEncode({
        "user_id": user.id,
        "first_name": user.FirstName,
        "last_name": user.LastName,
        "phone_number": user.PhoneNumber,
        "email": user.Email,
        "new_password": new_password,
        "confirm_password": confirm_password,
      }));
  if (reponsa.statusCode == 200) {
    print('yes');
    print(reponsa.body);
    return 1;
  } else {
    print('no');
    return 0;
  }
}

Future<List<User>> queryAllUsers() async {
  final url = "https://flutterprogayya.000webhostapp.com/getusers.php";
  http.Response reponsa = await http.get(Uri.parse(url));
  List<Map<String, dynamic>> users =
      List<Map<String, dynamic>>.from(jsonDecode(reponsa.body));
  return users.map((u) => User.fromMap(u)).toList();
}

Future<int> deleteAll() async {
  final url = "https://flutterprogayya.000webhostapp.com/deleteusers.php";
  http.Response reponsa = await http.get(Uri.parse(url));
  if (reponsa.statusCode == 200) {
    print('yes');
    return 1;
  } else {
    print('no');
    return 0;
  }
}
