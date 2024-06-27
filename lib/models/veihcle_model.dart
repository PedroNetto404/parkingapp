import 'package:parkingapp/models/model.dart';

import 'veihcle_type.dart';

class VeihcleModel extends Model {
  final String name;
  final String model;
  final String plate;
  final String color;
  final String customerId;
  final VeihcleType type;

  VeihcleModel(
      {super.id,
      required this.name,
      required this.model,
      required this.plate,
      required this.color,
      required this.customerId,
      required this.type});

  factory VeihcleModel.fromJson(Map<String, dynamic> json) => VeihcleModel(
      id: json['id'],
      name: json['name'],
      model: json['model'],
      plate: json['plate'],
      color: json['color'],
      type: VeihcleType.values
          .firstWhere((element) => element.name == json['type']),
      customerId: json['customerId']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'model': model,
        'plate': plate,
        'color': color,
        'customerId': customerId,
        'type': type.name
      };
}
