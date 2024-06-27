import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/customer_model.dart';

class CustomerRepository {
  final _customerCollection =
      FirebaseFirestore.instance.collection('customers');

  Future<void> create(CustomerModel customer) async =>
      await _customerCollection.add(customer.toJson());

  Future<CustomerModel> getById(String id) async =>
      CustomerModel.fromJson((await _customerCollection.doc(id).get()).data()!);

  Future<CustomerModel> get current async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception('No user logged in');
    }
    final customer = await _customerCollection.doc(user.uid).get();
    if (!customer.exists) {
      throw Exception('User not found in database');
    }
    return CustomerModel.fromJson(customer.data()!);
  }
}
