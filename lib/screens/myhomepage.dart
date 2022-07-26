import 'dart:developer';
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
  ApiHandler apiHandler = ApiHandler("https://mycima.tube/appweb/menus/");
  bool isSeries = true;
  @override
  void initState() {
    super.initState();
    // getApiData();
    // getCategoryPosts(categoryDataHandler);
  }

  // Future<dynamic> getApiData() async {
  //   ApiHandler apiHandler = ApiHandler("https://mycima.tube/appweb/menus/");
  //   var menusData = await apiHandler.getData();

  //   if (menusData.isEmpty) {
  //     log("menusData is null");
  //   } else {
  //     return menusData;
  //   }
  //   return menusData;
  // }

  // Future<dynamic> getCategoryPosts(CategoryData data) async {
  //   var categoryData = await data.getData();
  //   log("categoryData: $categoryData");
  //   if (categoryData.isEmpty) {
  //     log("seriesData is null");
  //   }

  //   return categoryData;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          child: FutureBuilder(
            future: apiHandler.getData(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == null || snapshot.data.isEmpty) {
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
                      collapsedTitleBackgroundColor:
                          Theme.of(context).appBarTheme.backgroundColor!,
                      contentBackgroundColor: Theme.of(context)
                          .appBarTheme
                          .backgroundColor!
                          .withOpacity(0.6),
                      expandedTitleBackgroundColor:
                          Theme.of(context).appBarTheme.backgroundColor!,
                      title: "${snapshot.data[index]["name"]}",
                      contentChild: SizedBox(
                        width: double.infinity,
                        height: 200,
                        child: ListView.builder(
                            itemCount: snapshot.data[index]["children"].length,
                            itemBuilder: ((context, index2) {
                              var name = snapshot.data[index]["children"]
                                  [index2]["name"];
                              return InkWell(
                                onTap: () {
                                  setState(() {
                                    categoryDataHandler = CategoryData(
                                        termID: snapshot.data[index]["children"]
                                            [index2]["id"]);
                                    (index == 0)
                                        ? isSeries = false
                                        : isSeries = true;
                                    Navigator.pop(context);
                                  });
                                },
                                child: ListTile(
                                  title: Text("$name"),
                                ),
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
          centerTitle: true,
          title: const Text('سيما'),
        ),
        body: Center(
          child: Container(
            padding: const EdgeInsets.fromLTRB(10, 50, 10, 0),
            child: FutureBuilder(
                future: categoryDataHandler.getData(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.data == null) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    log("snapshot.data: ${snapshot.data}");
                    return GridView.builder(
                      itemCount: snapshot.data.length,
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 250.0,
                        childAspectRatio: 6 / 8,
                        mainAxisSpacing: 10.0,
                        crossAxisSpacing: 10.0,
                      ),
                      itemBuilder: (_, index) {
                        String imageURL = snapshot.data[index]["thumbnailUrl"];
                        String cleanImageURL;
                        try {
                          cleanImageURL = (isSeries)
                              ? imageURL.replaceAll(
                                  imageURL.substring(
                                      imageURL.indexOf(
                                          ':', imageURL.indexOf(':') + 1),
                                      imageURL.indexOf(r'/wp')),
                                  "")
                              : imageURL;
                        } catch (e) {
                          cleanImageURL =
                              "images/failLoading/image_fail_loading.jpeg";
                        }

                        return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: bodyGridView(cleanImageURL,
                                "${snapshot.data[index]["title"]}"));
                      },
                    );
                  }
                }),
          ),
        ));
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
        fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white);
    return Card(
      color: const Color(0xff5367ff).withOpacity(0.6),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 150,
            child: Image.network(
              fit: BoxFit.fill,
              imageUrl,
              errorBuilder: (BuildContext context, Object exception,
                  StackTrace? stackTrace) {
                return Image.asset(
                    "images/failLoading/image_fail_loading.jpeg");
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
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
