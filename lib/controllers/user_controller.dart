//login getX controller
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:parkingapp/models/customer_model.dart';
import '../repositories/customer_repository.dart';

class UserController extends GetxController {
  final customerRepository = CustomerRepository();

  Future<void> signIn(
      {required String email,
      required String password,
      required bool keepConnected}) async {
    if (email.isEmpty || password.isEmpty) {
      throw Exception('Dados inválidos');
    }

    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signUp(
      {required String email,
      required String password,
      required String name}) async {
    if (email.isEmpty || password.isEmpty || name.isEmpty) {
      throw Exception('Dados inválidos');
    }

    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    await FirebaseAuth.instance.currentUser?.updateDisplayName(name);
  }

  Future<void> signOut() => FirebaseAuth.instance.signOut();

  Future<void> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<void> createCustomer(
      CustomerModel customer, bool isGoogleSignUp) async {
    if (!isGoogleSignUp) {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: customer.email, password: customer.password);
    }

    await signIn(
        email: customer.email,
        password: customer.password,
        keepConnected: customer.keepConnected);

    await FirebaseAuth.instance.currentUser?.updateDisplayName(customer.name);

    customer.id = FirebaseAuth.instance.currentUser!.uid;
    await customerRepository.create(customer);
  }
}
