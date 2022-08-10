import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cima/GetX/controllers/media_controller.dart';
import 'package:getwidget/components/accordion/gf_accordion.dart';
import 'package:cima/GetX/controllers/drawer_controller.dart' as drawer;
import '../models/movie_api.dart';

class HomePageDrawer extends StatefulWidget {
  const HomePageDrawer({Key? key}) : super(key: key);

  @override
  State<HomePageDrawer> createState() => _HomePageDrawerState();
}

class _HomePageDrawerState extends State<HomePageDrawer> {
  bool isSeries = true;
  drawer.DrawerController drawerController =
      drawer.DrawerController.getDrawerData();
  MediaController mediaController = MediaController.filteredDat();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: FutureBuilder(
        future: drawerController.drawerData,
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
                              setState(() {
                                mediaController.filteredData = FilteredData(
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
    );
  }
}
