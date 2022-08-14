import 'package:flutter/material.dart';
import 'package:cima/app/routes/myhomepage.dart';
import 'package:get/get.dart';
import 'package:cima/app/modules/Drawer/controllers/drawer_controller.dart'
    as drawer; // there is already a class called DrawerController so to avoid conflict we used the name drawer

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.put(drawer.DrawerController);

    return GetMaterialApp(
      title: 'Rest API Demo',
      theme: ThemeData(
          appBarTheme: const AppBarTheme(backgroundColor: Color(0xff5367ff)),
          scaffoldBackgroundColor: const Color(0xff0c0f21),
          drawerTheme:
              const DrawerThemeData(backgroundColor: Color(0xff0c0f21))),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
      locale: Get.deviceLocale,
      fallbackLocale: const Locale('ar', 'SA'),
    );
  }
}
