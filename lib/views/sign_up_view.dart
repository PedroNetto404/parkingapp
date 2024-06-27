import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../components/input_component.dart';
import '../components/veihcle_type_radio_component.dart';
import '../models/veihcle_type.dart';
import '../routes/app_routes.dart';
import '../controllers/user_controller.dart';
import '../models/customer_model.dart';
import '../models/veihcle_model.dart';

class SignUpView extends StatefulWidget {
  final bool isGoogleSignUp;

  const SignUpView({super.key, required this.isGoogleSignUp});

  @override
  State<SignUpView> createState() => SignUpViewState();
}

class SignUpViewState extends State<SignUpView> {
  final userController = Get.put(UserController());

  int currentStep = 0;

  @override
  void initState() {
    super.initState();
    if (widget.isGoogleSignUp) currentStep = 1;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: const Text('Parking App: Cadastro'),
      ),
      body: Stepper(
          currentStep: currentStep,
          elevation: 3,
          controlsBuilder: (BuildContext context, ControlsDetails details) =>
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: ElevatedButton(
                        onPressed: details.onStepContinue,
                        child:
                            Text(currentStep == 2 ? "Cadastrar" : "Continuar")),
                  ),
                  if (currentStep > 0)
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: TextButton(
                        onPressed: details.onStepCancel,
                        child: const Text('Voltar'),
                      ),
                    ),
                ],
              ),
          stepIconBuilder: (stepIndex, stepState) {
            if (stepState == StepState.complete) {
              return const Icon(Icons.check);
            }

            if (stepState == StepState.error) {
              return const Icon(Icons.error);
            }

            switch (stepIndex) {
              case 0:
                return const Icon(FontAwesomeIcons.key);
              case 1:
                return const Icon(Icons.person);
              case 2:
                return const Icon(Icons.car_rental);
              default:
                return const Icon(Icons.person);
            }
          },
          onStepContinue: () async {
            if (currentStep == 2) {
              if (!veihcleFormKey.currentState!.validate()) {
                Get.snackbar('Erro', 'Preencha os campos corretamente');
                return;
              }

              try {
                var customerModel = CustomerModel(
                    name: nameController.text,
                    email: emailController.text,
                    document: cpfController.text,
                    password: passwordController.text,
                    keepConnected: keepConnected);

                customerModel.veihcles.add(VeihcleModel(
                    name: veihcleNameController.text,
                    model: veihcleModelController.text,
                    plate: veihclePlateController.text,
                    color: veihcleColorController.text,
                    type: selectedVeihcleType,
                    customerId: customerModel.id));

                await userController.createCustomer(
                    customerModel, widget.isGoogleSignUp);

                Get.offAllNamed(AppRoutes.customerHome);
              } catch (e) {
                Get.snackbar('Erro', e.toString());
              }

              return;
            }

            if (currentStep == 0 &&
                !credentialsStepFormKey.currentState!.validate()) {
              Get.snackbar('Erro', 'Preencha os campos corretamente');
              return;
            }

            if (currentStep == 1 &&
                !personalDataStepFormKey.currentState!.validate()) {
              Get.snackbar('Erro', 'Preencha os campos corretamente');
              return;
            }

            setState(() => currentStep++);
          },
          onStepCancel: () => setState(() {
                if (currentStep > 0) currentStep--;
              }),
          steps: [
            _credentialsStep(context),
            _personalDataStep(context),
            _veihcleStep(context)
          ]));

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmationController = TextEditingController();
  final credentialsStepFormKey = GlobalKey<FormState>();

  bool keepConnected = false;

  _credentialsStep(context) => Step(
      title: const Text('Credenciais'),
      content: SingleChildScrollView(
        child: Form(
          key: credentialsStepFormKey,
          child: Column(
            children: [
              InputComponent(
                controller: emailController,
                label: 'E-mail',
                placeholder: 'john.doe"@gmail.com',
                prefix: const Icon(Icons.email),
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'Campo obrigatório';
                  }
                  if (!GetUtils.isEmail(value)) {
                    return 'E-mail inválido';
                  }
                  return null;
                },
              ),
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
                },
              ),
              const SizedBox(height: 16),
              InputComponent(
                label: 'Confirmação de senha',
                placeholder: '********',
                isPassword: true,
                controller: passwordConfirmationController,
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'Campo obrigatório';
                  }
                  if (value != passwordController.text) {
                    return 'Senhas não conferem';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              CheckboxListTile(
                  title: const Text('Manter-me conectado'),
                  value: keepConnected,
                  onChanged: (value) => setState(() => keepConnected = value!)),
            ],
          ),
        ),
      ));

  final nameController = TextEditingController();
  final cpfController = TextEditingController();
  final phoneController = TextEditingController();
  final personalDataStepFormKey = GlobalKey<FormState>();

  _personalDataStep(context) => Step(
      title: const Text('Dados pessoais'),
      content: SingleChildScrollView(
        child: Form(
          key: personalDataStepFormKey,
          child: Column(
            children: [
              InputComponent(
                controller: nameController,
                label: 'Nome',
                placeholder: 'John Doe',
                prefix: const Icon(Icons.person),
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'Campo obrigatório';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              InputComponent(
                keyboardType: TextInputType.number,
                controller: cpfController,
                label: 'CPF',
                placeholder: '000.000.000-00',
                prefix: const Icon(Icons.credit_card),
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'Campo obrigatório';
                  }

                  //regex para o cpf plano sem . e -
                  final regex = RegExp(r'^[0-9]{11}$');
                  if (!regex.hasMatch(value)) {
                    return 'CPF inválido';
                  }

                  return null;
                },
              ),
              const SizedBox(height: 16),
              InputComponent(
                controller: phoneController,
                label: 'Telefone',
                keyboardType: TextInputType.phone,
                placeholder: '(00) 00000-0000',
                prefix: const Icon(Icons.phone),
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'Campo obrigatório';
                  }

                  final regex = RegExp(r'^[0-9]{11}$');
                  if (!regex.hasMatch(value)) {
                    return 'Telefone inválido';
                  }

                  return null;
                },
              ),
            ],
          ),
        ),
      ));

  final veihcleNameController = TextEditingController();
  final veihcleModelController = TextEditingController();
  final veihclePlateController = TextEditingController();
  final veihcleColorController = TextEditingController();
  final veihcleFormKey = GlobalKey<FormState>();
  var selectedVeihcleType = VeihcleType.car;

  _veihcleStep(context) => Step(
      title: const Text('Veículo'),
      content: SingleChildScrollView(
        child: Form(
          key: veihcleFormKey,
          child: Column(
            children: [
              InputComponent(
                controller: veihcleNameController,
                label: 'Nome',
                placeholder: 'Fusca',
                prefix: const Icon(Icons.car_rental),
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'Campo obrigatório';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              InputComponent(
                controller: veihcleModelController,
                label: 'Modelo',
                placeholder: '1970',
                prefix: const Icon(Icons.car_rental),
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'Campo obrigatório';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              InputComponent(
                controller: veihclePlateController,
                label: 'Placa',
                placeholder: 'ABC-1234',
                prefix: const Icon(Icons.car_rental),
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'Campo obrigatório';
                  }

                  // final mercoSulRegex = RegExp(r'^[A-Z]{3}[0-9]{4}$');
                  // final oldPlateRegex = RegExp(r'^[A-Z]{3}[0-9]{3}$');

                  // if (!mercoSulRegex.hasMatch(value) &&
                  //     !oldPlateRegex.hasMatch(value)) {
                  //   return 'Placa inválida';
                  // }

                  return null;
                },
              ),
              const SizedBox(height: 16),
              InputComponent(
                controller: veihcleColorController,
                label: 'Cor',
                placeholder: 'Azul',
                prefix: const Icon(Icons.car_rental),
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'Campo obrigatório';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              VeihcleTypeRadioComponent(
                onChanged: (VeihcleType? value) {
                  if (value != null) {
                    setState(() => selectedVeihcleType = value);
                  }
                },
              )
            ],
          ),
        ),
      ));
}
