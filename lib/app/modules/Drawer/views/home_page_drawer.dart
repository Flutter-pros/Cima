import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/accordion/gf_accordion.dart';
//! we will use the HomepAgeBody controller (MediaController) to update the data in the home page body
import 'package:cima/app/modules/HomePageBody/controllers/media_controller.dart';
import '../controllers/drawer_controller.dart' as drawer;

class HomePageDrawer extends StatefulWidget {
  const HomePageDrawer({Key? key}) : super(key: key);

  @override
  State<HomePageDrawer> createState() => _HomePageDrawerState();
}

class _HomePageDrawerState extends State<HomePageDrawer> {
  bool isSeries = true;
  final drawer.DrawerController drawerController =
      Get.put(drawer.DrawerController());
  final MediaController mediaController = Get.put(MediaController());
  @override
  void initState() {
    super.initState();
    drawerController.updateDrawerData();
    mediaController.filterData();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Obx(
        () {
          if (drawerController.categories.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
              itemCount: drawerController.categories.length,
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
                  title: "${drawerController.categories[index]["name"]}",
                  contentChild: SizedBox(
                    width: double.infinity,
                    height: 200,
                    child: ListView.builder(
                        itemCount: drawerController.subCategories[index].length,
                        itemBuilder: ((context, index2) {
                          var name = drawerController.subCategories[index]
                              [index2]["name"];
                          return InkWell(
                            onTap: () {
                              final MediaController updatedMediaController =
                                  MediaController();
                              updatedMediaController.filterData(
                                  termID: drawerController.subCategories[index]
                                      [index2]["id"]);
                              mediaController.media =
                                  updatedMediaController.media;

                              (index == 0) ? isSeries = false : isSeries = true;
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
