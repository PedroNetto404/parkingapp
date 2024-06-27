import 'package:parkingapp/models/veihcle_model.dart';
import 'package:parkingapp/models/user_model.dart';

class CustomerModel extends UserModel {
  final List<VeihcleModel> veihcles = [];

  CustomerModel({
    super.id,
    required super.name,
    required super.document,
    required super.email,
    required super.password,
    required super.keepConnected,
  });

  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    final superData = UserModel.fromJson(json);

    final customer = CustomerModel(
      id: superData.id,
      name: superData.name,
      document: superData.document,
      email: superData.email,
      password: superData.password,
      keepConnected: superData.keepConnected,
    );

    if (json['veihcles'] != null) {
      for (var veihcle in json['veihcles']) {
        customer.veihcles.add(VeihcleModel.fromJson(veihcle));
      }
    }

    return customer;
  }
  
  @override
  Map<String, dynamic> toJson() => {
      ...super.toJson(),
      'veihcles': veihcles.map((e) => e.toJson()).toList(),
    };
}
