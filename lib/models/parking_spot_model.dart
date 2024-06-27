import 'package:parkingapp/models/customer_model.dart';
import 'package:parkingapp/models/model.dart';
import 'package:parkingapp/models/parking_spot_occupation.dart';

class ParkingSpotModel extends Model {
  final String area;
  final String code;
  final List<SpotAllocation> allocations;

  ParkingSpotModel(
      {required super.id,
      required this.area,
      required this.code,
      this.allocations = const []});

  String get location => '$area - $code';

  factory ParkingSpotModel.fromJson(Map<String, dynamic> json) =>
      ParkingSpotModel(
          id: json['id'],
          area: json['area'],
          code: json['code'],
          allocations: json['allocations']
              .map<SpotAllocation>((e) => SpotAllocation.fromJson(e))
              .toList());

  bool get canBeReserved => allocations.every((element) =>
      element.status != SpotAllocationStatus.started &&
      element.status != SpotAllocationStatus.waitingReserveAcceptance);

  bool get occupeid => allocations
      .any((element) => element.status == SpotAllocationStatus.started);

  bool get reserved => allocations.any((element) =>
      element.status == SpotAllocationStatus.waitingCheckIn ||
      element.status == SpotAllocationStatus.waitingReserveAcceptance);

  toJson() => {
        'id': id,
        'area': area,
        'code': code,
        'allocations': allocations.map((e) => e.toJson()).toList()
      };

  void tryReserveTo(CustomerModel customer) {}

  void reserveTo(String vehicleId, DateTime expectedCheckIn) {
    bool currentAllocated = allocations.any((element) =>
        element.status == SpotAllocationStatus.started ||
        element.status == SpotAllocationStatus.waitingReserveAcceptance);

    if (currentAllocated) {
      throw Exception('Vaga de estacionamento indisponível');
    }

    final spotAllocation = SpotAllocation.reserve(
        spotId: id, vehicleId: vehicleId, expectedCheckIn: expectedCheckIn);

    allocations.add(spotAllocation);
  }
}
