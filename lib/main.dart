import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tiktok_app/views/home_screen.dart';
import 'package:tiktok_app/views/login_screen.dart';

import 'bindings/auth_binding.dart';
import 'bindings/home_binding.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      builder: EasyLoading.init(),
      initialBinding: AuthBinding(),
      title: 'Tiktok App',
      theme: ThemeData(
              // primarySwatch: Colors.blue,
              )
          .copyWith(
        scaffoldBackgroundColor: Colors.black54,
        textTheme: const TextTheme(
          headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        ),
      ),
      home: const LoginScreen(),
      getPages: [
        GetPage(
            name: '/home', page: () => HomeScreen(), binding: HomeBinding()),
      ],
    );
  }
}
