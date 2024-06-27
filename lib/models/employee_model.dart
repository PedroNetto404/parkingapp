import 'package:parkingapp/models/user_model.dart';

class EmployeeModel extends UserModel {
  bool isAdministator;

  EmployeeModel(
      {
        super.id,
      required super.name,
      required super.document,
      required super.email,
      required super.password,
      required super.keepConnected,
      required this.isAdministator});

  factory EmployeeModel.fromJson(Map<String, dynamic> json) => EmployeeModel(
      id: json['id'],
      isAdministator: json['isAdministator'],
      name: json['name'],
      document: json['document'],
      email: json['email'],
      password: json['password'],
      keepConnected: json['keepConnected']);

  @override
  Map<String, dynamic> toJson() =>
      {...super.toJson(), 'isAdministator': isAdministator};
}
