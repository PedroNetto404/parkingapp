import 'package:parkingapp/models/model.dart';

enum SpotAllocationStatus {
  started,
  waitingReserveAcceptance,
  waitingCheckIn,
  finished,
  canceled
}

enum SpotAllocationType { reservation, occupation }

class SpotAllocation extends Model {
  String spotId;
  String vehicleId;
  DateTime? occupationStartedAt;
  DateTime? occupationEndedAt;
  DateTime? reservedAt;
  DateTime? reservationExpectedCheckIn;
  SpotAllocationType type = SpotAllocationType.occupation;
  SpotAllocationStatus status = SpotAllocationStatus.started;

  SpotAllocation(
      {super.id,
      required this.spotId,
      required this.vehicleId,
      this.type = SpotAllocationType.occupation,
      this.status = SpotAllocationStatus.started,
      this.reservedAt,
      this.occupationStartedAt,
      this.occupationEndedAt,
      this.reservationExpectedCheckIn});

  factory SpotAllocation.reserve(
          {required String spotId,
          required String vehicleId,
          required DateTime expectedCheckIn}) =>
      SpotAllocation(
          spotId: spotId,
          vehicleId: vehicleId,
          reservedAt: DateTime.now(),
          type: SpotAllocationType.reservation,
          status: SpotAllocationStatus.waitingReserveAcceptance,
          reservationExpectedCheckIn: expectedCheckIn);

  factory SpotAllocation.occupy(
          {required String spotId, required String vehicleId}) =>
      SpotAllocation(
          spotId: spotId,
          vehicleId: vehicleId,
          occupationStartedAt: DateTime.now(),
          type: SpotAllocationType.occupation,
          status: SpotAllocationStatus.started);

  factory SpotAllocation.fromJson(Map<String, dynamic> json) => SpotAllocation(
      id: json['id'],
      spotId: json['parkingSlotId'],
      vehicleId: json['vehicleId'],
      type: SpotAllocationType.values.firstWhere((e) => e.name == json['type']),
      status: SpotAllocationStatus.values
          .firstWhere((e) => e.name == json['status']),
      occupationStartedAt: json['occupationStartedAt'] != null
          ? DateTime.parse(json['occupationStartedAt'])
          : null,
      occupationEndedAt: json['occupationEndedAt'] != null
          ? DateTime.parse(json['occupationEndedAt'])
          : null,
      reservedAt: json['reservedAt'] != null
          ? DateTime.parse(json['reservedAt'])
          : null,
      reservationExpectedCheckIn: json['reservationExpectedCheckIn'] != null
          ? DateTime.parse(json['reservationExpectedCheckIn'])
          : null);

  Map<String, dynamic> toJson() => {
        'id': id,
        'parkingSlotId': spotId,
        'vehicleId': vehicleId,
        'status': status.name,
        'type': type.name,
        'occupationStartedAt': occupationStartedAt?.toIso8601String(),
        'occupationEndedAt': occupationEndedAt?.toIso8601String(),
        'reservedAt': reservedAt?.toIso8601String(),
        'reservationExpectedCheckIn':
            reservationExpectedCheckIn?.toIso8601String()
      };
}
