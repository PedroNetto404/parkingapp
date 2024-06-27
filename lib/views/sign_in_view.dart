import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../components/google_sign_component.dart';
import '../components/input_component.dart';
import '../controllers/user_controller.dart';
import '../routes/app_routes.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => SignInViewState();
}

class SignInViewState extends State<SignInView> {
  // Dependencies
  final UserController userController = Get.put(UserController());

  // State
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool keepConnected = false;

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: const Text('Parking App: Entre em sua conta'),
      ),
      body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _header(context),
              const SizedBox(height: 32),
              _form(context),
              const SizedBox(height: 32),
              _footer(context),
            ],
          )));

  _header(context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Entrar',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text('Bem-vindo de volta!',
              style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.secondary)),
        ],
      );

  _form(context) {
    fields() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InputComponent(
                controller: emailController,
                label: 'E-mail',
                placeholder: 'john.doe@gmail.com',
                prefix: const Icon(Icons.email),
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'Campo obrigatório';
                  }
                  if (!GetUtils.isEmail(value)) {
                    return 'E-mail inválido';
                  }
                  return null;
                }),
            const SizedBox(height: 16),
            InputComponent(
                label: 'Senha',
                placeholder: '********',
                isPassword: true,
                controller: passwordController,
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'Campo obrigatório';
                  }
                  if (value.length < 6) {
                    return 'Senha deve ter no mínimo 6 caracteres';
                  }
                  return null;
                })
          ],
        );

    signInButton() => SizedBox(
          width: double.infinity,
          child: ElevatedButton(
              onPressed: () async {
                if (!_formKey.currentState!.validate()) {
                  Get.snackbar('Erro', 'Preencha todos os campos');
                  return;
                }

                await userController.signIn(
                    email: emailController.text,
                    password: passwordController.text,
                    keepConnected: keepConnected);

                Get.offAllNamed(AppRoutes.customerHome);
              },
              child: const Text('Entrar', style: TextStyle(fontSize: 16))),
        );

    return Form(
        key: _formKey,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [fields(), const SizedBox(height: 16), signInButton()]));
  }

  _footer(context) => Column(
        children: [
          Row(
            children: [
              Expanded(
                  child:
                      Divider(color: Theme.of(context).colorScheme.secondary)),
              const Padding(
                  padding: EdgeInsets.all(8), child: Text('Ou entre com')),
              Expanded(
                  child:
                      Divider(color: Theme.of(context).colorScheme.secondary)),
            ],
          ),
          const SizedBox(height: 32),
          const GoogleSignComponent(),
          const SizedBox(height: 32),
          Center(
            child: TextButton(
              onPressed: () => Get.toNamed(AppRoutes.signUp),
              child: const Text('Não tem uma conta? Cadastre-se!'),
            ),
          ),
        ],
      );
}
