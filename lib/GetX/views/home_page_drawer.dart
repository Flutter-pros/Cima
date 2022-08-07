import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cima/GetX/controllers/movieController.dart';
import 'package:getwidget/components/accordion/gf_accordion.dart';

import '../models/movie_api.dart';

class HomePageDrawer extends StatefulWidget {
  const HomePageDrawer({Key? key}) : super(key: key);

  @override
  State<HomePageDrawer> createState() => _HomePageDrawerState();
}

class _HomePageDrawerState extends State<HomePageDrawer> {
  bool isSeries = true;
  MediaController mediaController = MediaController();

  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: const Color(0xff0c0f21),
        width: MediaQuery.of(context).size.width / 1.5,
        child: ListView(
          children: [
            Container(
              margin: const EdgeInsets.only(
                  top: 10, right: 10, left: 10, bottom: 10),
              child: TextFormField(
                  style: const TextStyle(color: Color(0xffffffff)),
                  cursorColor: const Color(0xffffffff),
                  decoration: InputDecoration(
                      hintText: "إبحث في ماي سيما",
                      hintStyle: const TextStyle(
                          fontSize: 13,
                          color: const Color(0xffa6a6b0),
                          fontWeight: FontWeight.bold),
                      prefixIcon: const Icon(Icons.search,
                          color: Color(0xff5367ff), size: 25),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      filled: true,
                      fillColor: const Color(0xff22263c))),
            ),
            Container(
              margin: const EdgeInsets.only(right: 10, left: 10, bottom: 10),
              child: ListTile(
                  leading: const Icon(
                    Icons.home,
                    size: 25,
                    color: const Color(0xff5367ff),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  tileColor: const Color(0xff22263c),
                  title: Text(
                    "الصفحه الرئيسيه",
                    style: const TextStyle(
                        color: Color(0xffa6a6b0), fontWeight: FontWeight.bold),
                  )),
            ),
            FutureBuilder(
              future: mediaController.apiHandler.getData(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data == null || snapshot.data.isEmpty) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: snapshot.data.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return ExpansionTile(
                                // childrenPadding: EdgeInsets.zero,
                                // tilePadding: EdgeInsets.zero,
                                title: Text(
                                  "${snapshot.data[index]['name']}",
                                  style: const TextStyle(
                                      fontSize:18.0, fontWeight:  FontWeight.w500,color: Colors.white),
                                ),
                                children: [
                                  SizedBox(
                                    width: double.infinity,
                                    height: 250,
                                    child: ListView.builder(
                                        scrollDirection: Axis.vertical,
                                        shrinkWrap: true,
                                        physics: const BouncingScrollPhysics(),
                                        itemCount: snapshot.data[index]["children"].length,
                                        itemBuilder: (context,index2){
                                          String name=snapshot.data[index]["children"][index2]['name'];
                                          return GestureDetector(
                                            onTap: (){
                                              setState(() {
                                                menuController.categoryData =
                                                    FilteredData(
                                                        termID: snapshot.data[index]["children"]
                                                        [index2]["id"]);
                                                (index == 0)
                                                    ? isSeries = false
                                                    : isSeries = true;
                                                Navigator.pop(context);
                                              });
                                            },
                                            child: ListTile(
                                              title: Text(name,style: const TextStyle(
                                                fontSize:18.0, fontWeight:  FontWeight.w500,color: Colors.white),),
                                            ),
                                          );
                                        }),
                                  ),
                                ],
                              );

                            });
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    }),

              ],
            ),
                    },
                  );
                }
              },
            ),
          ],
        ));
  }

//   List<InkWell> extractListOfInkwell(
//       AsyncSnapshot<dynamic> snapshot, int index) {
//     List<InkWell> extractedInkwells = [];
//     ListView.builder(
//         itemCount: snapshot.data[index]["children"].length,
//         itemBuilder: ((context, index2) {
//           var name = snapshot.data[index]["children"][index2]["name"];
//           extractedInkwells.add(InkWell(
//             onTap: () {
//               setState(() {
//                 mediaController.categoryDataHandler = FilteredData(
//                     termID: snapshot.data[index]["children"][index2]["id"]);
//                 (index == 0) ? isSeries = false : isSeries = true;
//                 Navigator.pop(context);
//               });
//             },
//             child: Container(
//               margin:
//                   const EdgeInsets.only(right: 25, left: 10, bottom: 5, top: 5),
//               child: Text(
//                 "$name",
//                 style: const TextStyle(
//                     color: Colors.white, fontWeight: FontWeight.bold),
//               ),
//             ),
//           ));
//         }));
//     return extractedInkwells;
//   }
// }




// GFAccordion(
//                         onToggleCollapsed: (isCollapsed) {
//                           log("");
//                         },
//                         expandedIcon: const Icon(Icons.keyboard_arrow_up,
//                             color: Color(0xff5367ff)),
//                         contentPadding: const EdgeInsets.only(top: 0),
//                         titlePadding: const EdgeInsets.all(18),
//                         contentBorderRadius: BorderRadius.circular(10),
//                         titleBorderRadius:
//                             const BorderRadius.all(Radius.circular(10)),
//                         margin: const EdgeInsets.only(
//                             right: 10, left: 10, bottom: 10),
//                         textStyle: const TextStyle(
//                             color: Color(0xffa6a6b0),
//                             fontWeight: FontWeight.bold),
//                         collapsedTitleBackgroundColor: const Color(0xff23273b),
//                         contentBackgroundColor: const Color(0xff23273b),
//                         expandedTitleBackgroundColor: const Color(0xff22263c),
//                         title: "${snapshot.data[index]["name"]}",
//                         contentChild: SizedBox(
//                           width: double.infinity,
//                           height: 200,
//                           child: ListView.separated(
//                               separatorBuilder: ((context, index) {
//                                 return const Divider(
//                                   color: const Color(0xffa6a6b0),
//                                 );
//                               }),
//                               itemCount:
//                                   snapshot.data[index]["children"].length,
//                               itemBuilder: ((context, index2) {
//                                 var name = snapshot.data[index]["children"]
//                                     [index2]["name"];
//                                 return InkWell(
//                                   onTap: () {
//                                     setState(() {
//                                       mediaController.categoryDataHandler =
//                                           FilteredData(
//                                               termID: snapshot.data[index]
//                                                   ["children"][index2]["id"]);
//                                       (index == 0)
//                                           ? isSeries = false
//                                           : isSeries = true;
//                                       Navigator.pop(context);
//                                     });
//                                   },
//                                   child: Container(
//                                     margin: const EdgeInsets.only(
//                                         right: 25, left: 10, bottom: 5, top: 5),
//                                     child: Text(
//                                       "$name",
//                                       style: const TextStyle(
//                                           color: Colors.white,
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                   ),
//                                 );
//                               })),
//                         ),
//                       );