import 'package:flutter/material.dart';
import 'package:cima/app/routes/myhomepage.dart';
import 'package:get/get.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
      locale: Get.deviceLocale,
      fallbackLocale: const Locale('ar', 'SA'),
    );
  }
}
