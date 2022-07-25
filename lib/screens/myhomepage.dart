import 'dart:developer';
import 'package:cima/screens/movie_info.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:cima/models/apihandler.dart';

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
  CategoryData categoryDataHandler = CategoryData();

  @override
  void initState() {
    super.initState();
    getApiData();
    getCategoryPosts(categoryDataHandler);
  }

  Future<dynamic> getApiData() async {
    ApiHandler apiHandler = ApiHandler("https://mycima.tube/appweb/menus/");
    var menusData = await apiHandler.getData();

    if (menusData.isEmpty) {
      log("menusData is null");
    } else {
      return menusData;
    }

    return menusData;
  }

  Future<dynamic> getCategoryPosts(CategoryData data) async {
    var categoryData = await data.getData();
    log("categoryData: $categoryData");
    if (categoryData.isEmpty) {
      log("seriesData is null");
    }

    return categoryData;
  }

  @override
  Widget build(BuildContext context) {
    var center = Center(
      child: Container(
        padding: const EdgeInsets.fromLTRB(10, 50, 10, 0),
        child: FutureBuilder(
            future: getCategoryPosts(categoryDataHandler),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                log("snapshot.data: ${snapshot.data}");
                return GridView.builder(
                  itemCount: snapshot.data.length,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 250.0,
                    childAspectRatio: 6 / 8,
                    mainAxisSpacing: 10.0,
                    crossAxisSpacing: 10.0,
                  ),
                  itemBuilder: (_, index) {
                    String cleanImageURL = snapshot.data[index]["thumbnailUrl"];
                    return bodyGridView(
                        "${cleanImageURL.replaceAll(":2083:2096", "")}",
                        "${snapshot.data[index]["title"]}");
                  },
                );
              }
            }),
      ),
    );
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
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    log("${snapshot.data[index]["name"]}");
                    return GFAccordion(
                      title: "${snapshot.data[index]["name"]}",
                      contentChild: SizedBox(
                        width: double.infinity,
                        height: 200,
                        child: ListView.builder(
                            itemCount: snapshot.data[index]["children"].length,
                            itemBuilder: ((context, index2) {
                              var name = snapshot.data[index]["children"]
                                  [index2]["name"];
                              return ListTile(
                                title: Text("$name"),
                              );
                            })),
                      ),
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
        body: center);
  }

  // ListView drawerNestedListTile(AsyncSnapshot<dynamic> snapshot, int index) {
  //   return ListView.builder(
  //       itemCount: snapshot.data[index]["children"].length,
  //       itemBuilder: (context, index2) {
  //         return ListTile(
  //           title: Text("${snapshot.data[index]["children"][index2]["name"]}"),
  //         );
  //       });
  // }

  Card bodyGridView(String imageUrl, String title) {
    const TextStyle textStyle = TextStyle(
        fontSize: 9, fontWeight: FontWeight.bold, color: Colors.white);
    return Card(
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Image.network(fit: BoxFit.scaleDown, imageUrl),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 3, 7),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  title,
                  style: textStyle,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
