import 'package:fire_crud_5a25/firebase_options.dart';
import 'package:fire_crud_5a25/screens/pets_screen.dart';
import 'package:fire_crud_5a25/screens/signin_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Firebase CRUD de Mascotas',
      home: SigninScreen(),
    );
  }
}
