import 'package:cima/app/utils/appcolors.dart';
import 'package:cima/app/utils/appfont.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
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

  List<IconData> icons = const [
    Icons.drive_file_move,
    Icons.live_tv,
    Icons.file_download,
    Icons.search
  ];
  List<int> expandedExpansionTiles = [];
  List<Color> iconsColors = [
    Colors.red,
    Colors.purple,
    Colors.black,
    Colors.black
  ];
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Drawer(
        width: Get.width / 1.3,
        backgroundColor: const Color.fromRGBO(14, 19, 49, 1),
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: ListView(children: [
            Container(
              margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color.fromRGBO(35, 40, 72, 1),
              ),
              child: TextFormField(
                style: TextStyle(color: AppColors().drawermenue),
                cursorColor: AppColors().blue,
                controller: searchController,
                onFieldSubmitted: (value) {
                  mediaController.searchRemoteData(
                      search: value.trim().toLowerCase());
                  Get.back();
                },
                decoration: InputDecoration(
                    focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(style: BorderStyle.none)),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Color.fromRGBO(35, 40, 72, 1),
                      ),
                    ),
                    hintStyle: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: AppFonts().fontsizehinttext,
                        color: AppColors().hinttext),
                    hintText: 'ابحث في ماي سيما',
                    prefixIcon: Icon(
                      Icons.search,
                      color: AppColors().textandsearchcolor,
                    )),
              ),
            ),
            Obx(() {
              return ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: mediaController.drawer.length,
                itemBuilder: (context, index) {
                  return Container(
                    //height: 70,
                    margin: const EdgeInsets.only(
                        top: 2, left: 10, right: 10, bottom: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color.fromRGBO(35, 40, 72, 1),
                    ),
                    child: ExpansionTile(
                      iconColor: AppColors().blue,
                      trailing: (mediaController.drawer[index]
                                  .mainCategorySubCategories.length !=
                              0)
                          ? null
                          : const Text(""),
                      tilePadding: EdgeInsets.zero,
                      onExpansionChanged: (value) {
                        if (value) {
                          setState(() {
                            expandedExpansionTiles.add(index);
                          });
                        } else {
                          setState(() {
                            expandedExpansionTiles.remove(index);
                          });
                        }
                      },
                      title: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Row(
                          children: [
                            Icon(icons[index],
                                color: (expandedExpansionTiles.contains(index))
                                    ? iconsColors[index]
                                    : Colors.black),
                            const SizedBox(
                              width: 10,
                            ),
                            InkWell(
                              onTap: () {
                                mediaController.filterData(
                                    termID: mediaController
                                        .drawer[index].mainCategoryID);
                              },
                              child: Text(
                                "${mediaController.drawer[index].mainCategoryName}",
                                softWrap: false,
                                overflow: TextOverflow.ellipsis,
                                //  textAlign: TextAlign.right,
                                style: TextStyle(
                                    fontSize: AppFonts().fontsizetext,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors().textandsearchcolor),
                              ),
                            ),
                          ],
                        ),
                      ),
                      children: [
                        ConstrainedBox(
                          constraints: const BoxConstraints(
                            maxHeight: 400,
                            minHeight: 10.0,
                          ),
                          child: ListView.separated(
                            separatorBuilder: ((context, index) {
                              return const Divider(
                                color: Colors.black,
                              );
                            }),
                            physics: const NeverScrollableScrollPhysics(),
                            //scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            //physics: const BouncingScrollPhysics(),
                            itemCount: mediaController
                                .drawer[index].mainCategorySubCategories.length,
                            itemBuilder: (context, index2) {
                              final name = mediaController.drawer[index]
                                  .mainCategorySubCategories[index2]["name"];
                              return GestureDetector(
                                onTap: () {
                                  mediaController.filterData(
                                      termID: mediaController.drawer[index]
                                              .mainCategorySubCategories[index2]
                                          ["id"]);

                                  Navigator.pop(context);
                                },
                                child: ListTile(
                                  title: Text(
                                    name!,
                                    softWrap: false,
                                    overflow: TextOverflow.ellipsis,
                                    //textAlign: TextAlign.right,
                                    style: TextStyle(
                                        fontSize: AppFonts().fontsizetext,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors().textandsearchcolor),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            })
          ]),
        ));
  }
}

//title: "${snapshot.data[index]["name"]}",
//itemCount: snapshot.data[index]["children"].length,
//  var name =snapshot.data[index]["children"][index2]["name"];


  // onTap: () {
  //                               var updatedMediaController = MediaController();
  //                               updatedMediaController.filterData(
  //                                   termID: snapshot.data[index]["children"]
  //                                       [index2]["id"]);
      
  //                               mediaController.media.value =
  //                                   updatedMediaController.media;
      
  //                               (index == 0)
  //                                   ? mediaController.isSeries.value = false
  //                                   : mediaController.isSeries.value = true;
  //                               Navigator.pop(context);
  //                             },
  

  
  //   child: ListTile(
  //                               title: Text("$name"),
  //                             ),