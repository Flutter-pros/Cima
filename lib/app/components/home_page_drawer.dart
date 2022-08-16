import 'package:cima/app/data/movie_api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/accordion/gf_accordion.dart';
//! we will use the HomepAgeBody controller (MediaController) to update the data in the home page body
import 'package:cima/app/modules/HomePageBody/controllers/media_controller.dart';
// import '../modules/Drawer/controllers/drawer_controller.dart' as drawer;

class HomePageDrawer extends StatefulWidget {
  const HomePageDrawer({Key? key}) : super(key: key);

  @override
  State<HomePageDrawer> createState() => _HomePageDrawerState();
}

class _HomePageDrawerState extends State<HomePageDrawer> {
  final MediaController mediaController = Get.put(MediaController());
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: FutureBuilder(
        future: DrawerData().getData(),
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
                          var name =
                              snapshot.data[index]["children"][index2]["name"];
                          return InkWell(
                            onTap: () {
                              var updatedMediaController = MediaController();
                              updatedMediaController.filterData(
                                  termID: snapshot.data[index]["children"]
                                      [index2]["id"]);

                              mediaController.media.value =
                                  updatedMediaController.media;

                              (index == 0)
                                  ? mediaController.isSeries.value = false
                                  : mediaController.isSeries.value = true;
                              Navigator.pop(context);
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
    );
  }
}
