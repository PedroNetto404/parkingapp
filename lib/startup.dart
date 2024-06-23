import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:parkingapp/theme.dart';

class Startup extends StatelessWidget {
  @override
  Widget build(BuildContext context) => GetMaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Flutter GetX Demo',
    theme: AppTheme.darkTheme,
  );
}