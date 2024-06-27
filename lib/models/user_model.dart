import 'package:parkingapp/models/model.dart';

class UserModel extends Model {
  final String name;
  final String document;
  final String email;
  final String password;
  final bool keepConnected;

  UserModel(
      {super.id,
      required this.name,
      required this.document,
      required this.email,
      required this.password,
      required this.keepConnected});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
      id: json['id'],
      name: json['name'],
      document: json['document'],
      email: json['email'],
      password: json['password'],
      keepConnected: json['keepConnected']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'document': document,
        'email': email,
        'password': password,
        'keepConnected': keepConnected
      };
}
