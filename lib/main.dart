import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kpop_info/di/init_get_it.dart';
import 'package:kpop_info/firebase_options.dart';
import 'package:kpop_info/test_page.dart';
import 'package:kpop_info/ui/home/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
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
    return const CupertinoApp(
      debugShowCheckedModeBanner: false,
      title: 'Kpop Xplore',
      theme: CupertinoThemeData(
        primaryColor: Color(0xFFC93D41),
      ),
      home: HomePage(),
    );
  }
}
