import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kpop_info/di/init_get_it.dart';
import 'package:kpop_info/firebase_options.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KPop info',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Text('KPop info'),
    );
  }
}
