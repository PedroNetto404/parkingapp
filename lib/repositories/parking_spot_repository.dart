import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:parkingapp/models/parking_spot_model.dart';

class ParkingSpotRepository {
  final _collection = FirebaseFirestore.instance.collection('parking_spots');

  Stream<QuerySnapshot<Map<String, dynamic>>> get realTimeSpots =>
      _collection.snapshots();

  Future<void> create(ParkingSpotModel parkingSpot) async =>
      await _collection.add(parkingSpot.toJson());

  Future<ParkingSpotModel> getById(String id) async =>
      ParkingSpotModel.fromJson((await _collection.doc(id).get()).data()!);

  Future<void> update(ParkingSpotModel parkingSpot) async =>
      await _collection.doc(parkingSpot.id).update(parkingSpot.toJson());

  Future<void> delete(String id) async => await _collection.doc(id).delete();

  Future<List<ParkingSpotModel>> getAll() async => (await _collection.get())
      .docs
      .map((doc) => ParkingSpotModel.fromJson(doc.data()))
      .toList();
}
