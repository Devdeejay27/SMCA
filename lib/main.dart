import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:smca/firebase_options.dart';
import 'package:smca/pages/login_page.dart';
import 'package:smca/pages/register_page.dart';
import 'package:smca/themes/light_mode.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
      theme: lightMode,
    );
  }
}
