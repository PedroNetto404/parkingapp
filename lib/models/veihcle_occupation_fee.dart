import 'package:parkingapp/models/model.dart';
import 'package:parkingapp/models/veihcle_type.dart';

class VeihcleOccupationFee extends Model {
  final VeihcleType veihcleType;
  final double feePerHour;

  VeihcleOccupationFee(
      {required super.id, required this.veihcleType, required this.feePerHour});

  factory VeihcleOccupationFee.fromJson(Map<String, dynamic> json) =>
      VeihcleOccupationFee(
          id: json['id'],
          veihcleType: json['veihcleType'],
          feePerHour: json['feePerHour']);

  Map<String, dynamic> toJson() =>
      {'id': id, 'veihcleType': veihcleType, 'feePerHour': feePerHour};
}
