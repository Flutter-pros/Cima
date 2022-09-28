import 'package:cima/app/utils/appcolors.dart';
import 'package:cima/app/utils/appfont.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
//! we will use the HomepAgeBody controller (MediaController) to update the data in the home page body
import 'package:cima/app/modules/HomePageBody/controllers/media_controller.dart';
import 'package:cima/app/library/globals.dart' as globals;
// import '../modules/Drawer/controllers/drawer_controller.dart' as drawer;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
    FontAwesomeIcons.satelliteDish,
    FontAwesomeIcons.dumbbell,
  ];
  List<int> expandedExpansionTiles = [];
  List<Color> iconsColors = [
    Colors.red,
    Colors.purple,
    Colors.yellow,
    Colors.black
  ];

  List<Color> togglecolors = [
    Colors.red,
    Colors.purple,
    Colors.black,
    Colors.black
  ];

  void requestFocus() {
    setState(() {
      FocusScope.of(context).requestFocus(myFocusNode);
    });
  }

  TextEditingController searchController = TextEditingController();
  FocusNode myFocusNode = FocusNode();

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
                // color: const Color.fromRGBO(35, 40, 72, 1),
              ),
              child: TextFormField(
                onTap: requestFocus,
                focusNode: myFocusNode,
                style: TextStyle(color: AppColors().drawermenue),
                cursorColor: AppColors().blue,
                controller: searchController,
                onFieldSubmitted: (value) {
                  mediaController.searchRemoteData(
                      search: value.trim().toLowerCase());
                  Get.back();
                },
                decoration: InputDecoration(
                    fillColor: myFocusNode.hasFocus
                        ? const Color.fromRGBO(35, 40, 72, 1)
                        : const Color.fromRGBO(14, 19, 49, 1),
                    filled: true,
                    focusedBorder: UnderlineInputBorder(
                        borderSide: const BorderSide(style: BorderStyle.none),
                        borderRadius: BorderRadius.circular(10)),
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
              return InkWell(
                splashColor: const Color.fromRGBO(14, 19, 49, 1),
                highlightColor: const Color.fromRGBO(14, 19, 49, 1),
                onTap: () {
                  mediaController.changecolorinlisttile.value = -1;

                  for (var index = 1;
                      index < mediaController.media.length;
                      index++) {
                    mediaController.media.removeAt(index);
                    mediaController.isFirstScreen.value = true;
                    mediaController.isPreviousActivated.value = false;
                  }
                },
                child: Container(
                  margin:
                      const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: mediaController.changecolorinlisttile.value == -1
                        ? const Color.fromRGBO(35, 40, 72, 1)
                        : null,
                  ),
                  padding: const EdgeInsets.only(right: 7),
                  child: Row(
                    children: [
                      Icon(Icons.home, size: 30, color: AppColors().blue),
                      const SizedBox(width: 6),
                      Text(
                        "الصفحة الرئيسية",
                        style: TextStyle(
                            fontSize: AppFonts().fontsizetext,
                            fontWeight: FontWeight.w500,
                            color: AppColors().textandsearchcolor),
                      ),
                    ],
                  ),
                ),
              );
            }),
            Obx(() {
              return ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: mediaController.drawer.length,
                itemBuilder: (context, index) {
                  return Obx(() {
                    return Container(
                      //height: 70,
                      margin: const EdgeInsets.only(
                          top: 2, left: 10, right: 10, bottom: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color:
                            mediaController.changecolorinlisttile.value == index
                                ? const Color.fromRGBO(35, 40, 72, 1)
                                : null,
                      ),
                      child: ExpansionTile(
                        backgroundColor: const Color.fromRGBO(14, 19, 49, 1),
                        collapsedIconColor: AppColors().textandsearchcolor,
                        iconColor: togglecolors[index],
                        trailing: (mediaController.drawer[index]
                                    .mainCategorySubCategories.length !=
                                0)
                            ? null
                            : const Text(""),
                        tilePadding: const EdgeInsets.only(right: 5),
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
                          padding: const EdgeInsets.only(right: 5.0),
                          child: Row(
                            children: [
                              Icon(icons[index],
                                  color:
                                      (expandedExpansionTiles.contains(index))
                                          ? iconsColors[index]
                                          : iconsColors[index]),
                              const SizedBox(
                                width: 10,
                              ),
                              InkWell(
                                onTap: () {
                                  mediaController.changecolorinlisttile.value =
                                      index;
                                  mediaController.changecolorinlisttile.value =
                                      index;
                                  globals.isSeries =
                                      (index == 1) ? true : false;

                                  mediaController.categorizeData(
                                      categoryID: mediaController
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
                              itemCount: mediaController.drawer[index]
                                  .mainCategorySubCategories.length,
                              itemBuilder: (context, index2) {
                                final name = mediaController.drawer[index]
                                    .mainCategorySubCategories[index2]["name"];
                                return GestureDetector(
                                  onTap: () {
                                    mediaController
                                        .changecolorinlisttile.value = index;
                                    globals.isSeries =
                                        (index == 1) ? true : false;
                                    mediaController.categorizeData(
                                        categoryID: mediaController
                                                .drawer[index]
                                                .mainCategorySubCategories[
                                            index2]["id"]);

                                    Navigator.pop(context);
                                  },
                                  child: ListTile(
                                    title: Flexible(
                                      child: Container(
                                        padding:
                                            const EdgeInsets.only(right: 13.0),
                                        child: Text(
                                          name!,
                                          softWrap: false,
                                          overflow: TextOverflow.ellipsis,
                                          //textAlign: TextAlign.right,
                                          style: TextStyle(
                                              fontSize: AppFonts().fontsizetext,
                                              fontWeight: FontWeight.w500,
                                              color: AppColors()
                                                  .textandsearchcolor),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  });
                },
              );
            }),
            Obx(() {
              return InkWell(
                splashColor: const Color.fromRGBO(14, 19, 49, 1),
                highlightColor: const Color.fromRGBO(14, 19, 49, 1),
                onTap: () {
                  mediaController.changecolorinlisttile.value = -2;
                },
                child: Container(
                  margin:
                      const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: mediaController.changecolorinlisttile.value == -2
                        ? const Color.fromRGBO(35, 40, 72, 1)
                        : null,
                  ),
                  padding: const EdgeInsets.only(right: 7),
                  child: Row(
                    children: [
                      const Icon(Icons.shopping_cart,
                          size: 30, color: Color(0xffd87c2b)),
                      const SizedBox(width: 6),
                      Text(
                        "انيمي وكرتون",
                        style: TextStyle(
                            fontSize: AppFonts().fontsizetext,
                            fontWeight: FontWeight.w500,
                            color: AppColors().textandsearchcolor),
                      ),
                    ],
                  ),
                ),
              );
            }),
            Obx(() {
              return InkWell(
                splashColor: const Color.fromRGBO(14, 19, 49, 1),
                highlightColor: const Color.fromRGBO(14, 19, 49, 1),
                onTap: () {
                  mediaController.changecolorinlisttile.value = -3;
                },
                child: Container(
                  margin:
                      const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: mediaController.changecolorinlisttile.value == -3
                        ? const Color.fromRGBO(35, 40, 72, 1)
                        : null,
                  ),
                  padding: const EdgeInsets.only(right: 13),
                  child: Row(
                    children: [
                      Icon(FontAwesomeIcons.dumbbell,
                          size: 25, color: AppColors().blue),
                      const SizedBox(width: 7),
                      Text(
                        "مصارعة حرة",
                        style: TextStyle(
                            fontSize: AppFonts().fontsizetext,
                            fontWeight: FontWeight.w500,
                            color: AppColors().textandsearchcolor),
                      ),
                    ],
                  ),
                ),
              );
            }),
            Obx(() {
              return InkWell(
                splashColor: const Color.fromRGBO(14, 19, 49, 1),
                highlightColor: const Color.fromRGBO(14, 19, 49, 1),
                onTap: () {
                  mediaController.changecolorinlisttile.value = -4;
                },
                child: Container(
                  margin:
                      const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: mediaController.changecolorinlisttile.value == -4
                        ? const Color.fromRGBO(35, 40, 72, 1)
                        : null,
                  ),
                  padding: const EdgeInsets.only(right: 7),
                  child: Row(
                    children: [
                      const Icon(FontAwesomeIcons.satelliteDish,
                          size: 30, color: Color(0xff6aaf3c)),
                      const SizedBox(width: 7),
                      Text(
                        "برامج تليفزيونية",
                        style: TextStyle(
                            fontSize: AppFonts().fontsizetext,
                            fontWeight: FontWeight.w500,
                            color: AppColors().textandsearchcolor),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ]),
        ));
  }
}
