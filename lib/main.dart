import 'package:flutter/material.dart';
import 'package:cima/app/myapp.dart';
import 'package:http/http.dart' as http;
import 'package:cima/app/library/globals.dart' as globals;

isConnectionEstablished() async {
  var result = await http.get(Uri.parse("globals.domain"));
  if (result.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}

void main(List<String> args) {
  if (isConnectionEstablished()) {
    globals.domain =
        "call here the function which will return the active domain";
  }
  runApp(const MyApp());
}
