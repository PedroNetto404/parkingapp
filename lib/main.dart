import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:parkingapp/controllers/parking_controller.dart';
import 'package:parkingapp/controllers/user_controller.dart';
import 'package:parkingapp/repositories/parking_spot_repository.dart';
import 'package:parkingapp/startup.dart';
import 'firebase_options.dart';
import 'models/parking_spot_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  setupDependencies();
  await seedData();

  runApp(const Startup());
}

void setupDependencies() {
  Get.put(ParkingController());
  Get.put(UserController());
}

Future<void> seedData() async {
  final parkingSpotRepository = ParkingSpotRepository();

  final currentSpots = await parkingSpotRepository.getAll();
  if (currentSpots.isNotEmpty) {
    return;
  }

  List<ParkingSpotModel> parkingSlots = List.generate(10, (index) {
    return ParkingSpotModel(
        id: 'slot$index',
        area: 'A', 
        code: 'A$index');
  });

  final futures =
      parkingSlots.map((slot) => parkingSpotRepository.create(slot));
  await Future.wait(futures);
}
