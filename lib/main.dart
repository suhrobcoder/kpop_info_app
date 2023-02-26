import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:kpop_info/di/init_get_it.dart';
import 'package:kpop_info/firebase_options.dart';
import 'package:kpop_info/ui/group_list/group_list_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
      title: 'KPop info',
      theme: CupertinoThemeData(
        primaryColor: Color(0xFFC93D41),
      ),
      home: GroupListPage(),
    );
  }
}