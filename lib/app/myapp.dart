import 'package:cima/app/local/local.dart';
import 'package:cima/app/routes/content.dart';
import 'package:cima/app/routes/movie_info.dart';
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
      initialRoute: "/",
      getPages: [
        GetPage(name: "/", page: () => const MyHomePage()),
        GetPage(name: "/movie_info", page: () => const MovieInfoScreen()),
        // GetPage(name: "/content", page: () => const Content())
      ],
      translations: MyLocal(),
      locale: Get.deviceLocale,
      fallbackLocale: const Locale('ar', 'SA'),
    );
  }
}
