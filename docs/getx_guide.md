
# Guia Rápido de GetX em Flutter

## Estrutura de Pastas
A estrutura de pastas para um projeto usando GetX pode ser organizada da seguinte maneira:

```
lib/
├── controllers/
│   └── home_controller.dart
├── models/
│   └── user_model.dart
├── views/
│   └── home_view.dart
├── widgets/
│   └── custom_button.dart
├── main.dart
```

## Instalando o GetX
Adicione a dependência no `pubspec.yaml`:

```yaml
dependencies:
  get: ^4.6.1
```

## Criando um Controller
Um Controller em GetX é usado para gerenciar a lógica de estado.

```dart
// lib/controllers/home_controller.dart
import 'package:get/get.dart';

class HomeController extends GetxController {
  var count = 0.obs;

  void increment() {
    count++;
  }
}
```

## Criando uma View
Uma View em GetX é um widget que exibe a interface do usuário.

```dart
// lib/views/home_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:your_project/controllers/home_controller.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.put(HomeController());

    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Center(
        child: Obx(() {
          return Text('Count: ${homeController.count}');
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: homeController.increment,
        child: Icon(Icons.add),
      ),
    );
  }
}
```

## Configurando o Main
O `main.dart` configura a aplicação e define a rota inicial.

```dart
// lib/main.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:your_project/views/home_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter GetX Demo',
      home: HomeView(),
    );
  }
}
```

## Principais Widgets e Heranças

1. **GetMaterialApp**: Substitui o `MaterialApp` padrão.
2. **GetX** e **Obx**: Observam e reagem às mudanças no estado.
3. **Get.put()**: Injeta um controller na árvore de widgets.
4. **Get.find()**: Encontra um controller já existente.

## Exemplo de Widget Personalizado

```dart
// lib/widgets/custom_button.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  CustomButton({required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(label),
    );
  }
}
```

## Exemplo de Modelo

```dart
// lib/models/user_model.dart
class UserModel {
  String name;
  int age;

  UserModel({required this.name, required this.age});
}
```

## Integrando o Modelo com o Controller

```dart
// lib/controllers/home_controller.dart
import 'package:get/get.dart';
import 'package:your_project/models/user_model.dart';

class HomeController extends GetxController {
  var user = UserModel(name: 'John Doe', age: 25).obs;

  void updateUserName(String newName) {
    user.update((val) {
      val?.name = newName;
    });
  }
}
```

## Exemplo de Uso do Modelo na View

```dart
// lib/views/home_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:your_project/controllers/home_controller.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.put(HomeController());

    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() {
              return Text('User: ${homeController.user.value.name}');
            }),
            SizedBox(height: 20),
            CustomButton(
              label: 'Update Name',
              onPressed: () {
                homeController.updateUserName('Jane Doe');
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: homeController.increment,
        child: Icon(Icons.add),
      ),
    );
  }
}
```
