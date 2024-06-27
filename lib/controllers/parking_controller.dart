import 'package:get/get.dart';
import 'package:parkingapp/models/parking_spot_model.dart';

import '../repositories/customer_repository.dart';
import '../repositories/parking_spot_repository.dart';

class ParkingController extends GetxController {
  final customerRepository = CustomerRepository();
  final parkingSpotRepository = ParkingSpotRepository();

  Future<void> reserveSpot(
      {required ParkingSpotModel spot,
      required DateTime expectedCheckIn,
      required String vehicleId}) async {
    spot.reserveTo(vehicleId, expectedCheckIn);
    await parkingSpotRepository.update(spot);
  }
}
