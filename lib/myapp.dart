import 'package:cima/localization/applocal.dart';
import 'package:flutter/material.dart';
import 'package:cima/screens/myhomepage.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rest API Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
      localizationsDelegates: const [
        AppLocale.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: const [Locale("en", ""), Locale("ar", "")],
      localeResolutionCallback: (currentlang, supportlang) {
        if (currentlang != null) {
          for (Locale locale in supportlang) {
            if (locale.languageCode == currentlang.languageCode) {
              return currentlang;
            }
          }
        }
        return supportlang.first;
      },
    );
  }
}
