// ignore: file_names
import 'package:flutter/material.dart';
import 'package:cima/screens/myhomepage.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:cima/GetX/models/movie_api.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _LoadingScreenState();
  }
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getApiData();
  }

  void getApiData() async {
    ApiHandler apiHandler = ApiHandler("https://mycima.tube/appweb/menus");
    var menus = await apiHandler.getData();
    // ignore: use_build_context_synchronously
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return const MyHomePage();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.white,
          size: 100.0,
        ),
      ),
    );
  }
}
