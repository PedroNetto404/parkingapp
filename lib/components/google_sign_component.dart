import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:parkingapp/views/sign_up_view.dart';
import '../controllers/user_controller.dart';

class GoogleSignComponent extends StatefulWidget {
  const GoogleSignComponent({super.key});

  @override
  State<GoogleSignComponent> createState() => _GoogleSignComponentState();
}

class _GoogleSignComponentState extends State<GoogleSignComponent> {
  // Dependencies
  final UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) => ElevatedButton.icon(
      onPressed: () async {
        try {
          await userController.signInWithGoogle();
          Get.to(() => const SignUpView(isGoogleSignUp: true));
        } catch (e) {
          Get.snackbar('Erro', e.toString());
        }
      },
      icon: const Icon(FontAwesomeIcons.google),
      label: const Text('Entrar com Google'));
}
