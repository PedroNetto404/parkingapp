import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:parkingapp/routes/app_routes.dart';
import 'package:parkingapp/theme.dart';

class Startup extends StatelessWidget {
  const Startup({super.key});

  @override
  Widget build(BuildContext context) => GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Parking App',
      theme: AppTheme.theme,
      initialRoute: AppRoutes.initial,
      getPages: AppRoutes.routes);
}
