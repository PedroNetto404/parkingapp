import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:parkingapp/startup.dart';
import 'firebase_options.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  WidgetsFlutterBinding.ensureInitialized();
  
  runApp(Startup());
}

