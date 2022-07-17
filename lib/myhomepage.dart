import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:cima/apihandler.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // int temperature;
  // String weatherIcon;
  // String cityName;
  // String weatherMessage;
  dynamic movies = {};
  dynamic series = {};
  dynamic downloads = {};
  @override
  void initState() {
    super.initState();
    getApiData();
  }

  Future<dynamic> getApiData() async {
    ApiHandler apiHandler = ApiHandler("https://mycima.tube/appweb/menus/");
    var menusData = await apiHandler.getData();

    if (menusData.isEmpty) {
      log("menusData is null");
    } else {
      return menusData;
    }
    // movies = menusData[0];
    // series = menusData[1];
    // downloads = menusData[2];
    // log("movies: $movies");
    return menusData;
  }

  @override
  Widget build(BuildContext context) {
    // var drawer2 = Drawer(
    //   child: ListView(
    //     children: [
    //       GFAccordion(
    //         title: "Movies",
    //         contentChild: Column(children: const [
    //           ListTile(
    //             title: Text("Movie 1"),
    //           ),
    //           ListTile(
    //             title: Text("Movie 2"),
    //           ),
    //           ListTile(
    //             title: Text("Movie 3"),
    //           ),
    //         ]),
    //       ),
    //       GFAccordion(
    //         title: "Series",
    //         contentChild: Column(children: const [
    //           ListTile(
    //             title: Text("Series 1"),
    //           ),
    //           ListTile(
    //             title: Text("Series 2"),
    //           ),
    //           ListTile(
    //             title: Text("Series 3"),
    //           ),
    //         ]),
    //       ),
    //     ],
    //   ),
    // );
    return Scaffold(
      drawer: Drawer(
        child: FutureBuilder(
          future: getApiData(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return GFAccordion(
                    title: "${snapshot.data[index]["name"]}",
                    contentChild: drawerNestedListTile(snapshot, index),
                  );
                },
              );
            }
          },
        ),
      ),
      appBar: AppBar(
        title: const Text('Cima'),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.fromLTRB(10, 50, 10, 0),
          child: GridView(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 150.0,
              childAspectRatio: 3 / 3,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
            ),
            children: [
              Container(
                color: Colors.red,
              ),
              Container(color: Colors.red),
              Container(color: Colors.red)
            ],
          ),
        ),
      ),
    );
  }

  ListView drawerNestedListTile(AsyncSnapshot<dynamic> snapshot, int index) {
    return ListView.builder(
        itemCount: snapshot.data[index]["children"].length,
        itemBuilder: (context, index2) {
          return ListTile(
            title: Text("${snapshot.data[index]["children"][index2]["name"]}"),
          );
        });

    // "${snapshot.data[index]["children"][index]["name"]}"),
  }

  // GFAccordion DrawerLVGFAccordion(String title, List<String> titles) {
  //   return GFAccordion(
  //     title: title,
  //     contentChild: Column(children: const [
  //       ListTile(
  //         title: Text("${titles[0]}"),
  //       ),
  //       ListTile(
  //         title: Text("Movie 2"),
  //       ),
  //       ListTile(
  //         title: Text("Movie 3"),
  //       ),
  //     ]),
  //   );
  // }
}
