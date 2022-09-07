import 'package:cima/app/components/grid_view_body_card.dart';
import 'package:cima/app/components/video_player.dart';

import 'package:cima/app/data/movie_api.dart';
import 'package:cima/app/modules/HomePageBody/controllers/media_controller.dart';

import 'package:cima/app/components/row_and_details.dart';
import 'package:cima/app/utils/textutils.dart';
import 'package:cima/appcolors.dart';
import 'package:cima/appfont.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MovieInfoScreen extends StatefulWidget {
  const MovieInfoScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<MovieInfoScreen> createState() => _MovieInfoScreenState();
}

class _MovieInfoScreenState extends State<MovieInfoScreen> {
  final MediaController mediaController = Get.put(MediaController());

  bool u = false;

  Widget stackFunction() {
    if (u == false) {
      return SizedBox(
          height: Get.height * .4,
          width: Get.width,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Image.network(
                'https://static.remove.bg/remove-bg-web/829f26b46f699752c3849e83798ce277bfc6b0c7/assets/start_remove-c851bdf8d3127a24e2d137a55b1b427378cd17385b01aec6e59d5d4b5f39d2ec.png',
                fit: BoxFit.cover,
              ),
              Positioned(
                  top: 38,
                  left: 10,
                  child: IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios_new_outlined,
                        color: Colors.white,
                      ))),
              Positioned(
                  child: CircleAvatar(
                radius: 35,
                backgroundColor: Colors.black,
                child: IconButton(
                    onPressed: () {
                      setState(() {
                        u = true;
                      });
                    },
                    icon: const Icon(
                      Icons.play_arrow_outlined,
                      color: Colors.red,
                    )),
              )),
            ],
          ));
    } else {
      return SizedBox(
          height: Get.height * .4,
          width: Get.width,
          child: Stack(
            children: [
              const VideoPlayer(),
              Positioned(
                  top: 38,
                  left: 10,
                  child: IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios_new_outlined,
                        color: Colors.white,
                      )))
            ],
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final MediaControllerData argument = Get.arguments as MediaControllerData;

    return Scaffold(
        body: Container(
            color: Colors.black,
            height: double.infinity,
            width: double.infinity,
            child: SingleChildScrollView(
              child: FutureBuilder(
                future: argument.getMoreDetails(),
                builder: (context, snapshot) => Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      stackFunction(),
                      // SizedBox(
                      //   height: Get.height * .4,
                      //   width: Get.width,
                      //   child: Stack(
                      //     alignment: Alignment.center,
                      //     children: [
                      //       Image.network(
                      //         'https://static.remove.bg/remove-bg-web/829f26b46f699752c3849e83798ce277bfc6b0c7/assets/start_remove-c851bdf8d3127a24e2d137a55b1b427378cd17385b01aec6e59d5d4b5f39d2ec.png',
                      //         fit: BoxFit.cover,
                      //       ),
                      //       Positioned(
                      //           top: 38,
                      //           left: 10,
                      //           child: IconButton(
                      //               onPressed: () {
                      //                 Get.back();
                      //               },
                      //               icon: const Icon(
                      //                 Icons.arrow_back_ios_new_outlined,
                      //                 color: Colors.white,
                      //               ))),
                      //       Positioned(
                      //           child: CircleAvatar(
                      //         radius: 35,
                      //         backgroundColor: Colors.black,
                      //         child: IconButton(
                      //             onPressed: () {},
                      //             icon: const Icon(
                      //               Icons.play_arrow_outlined,
                      //               color: Colors.red,
                      //             )),
                      //       )),
                      //     ],
                      //   ),
                      // ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            DetailsRow(
                              mediaAging: argument.mediaAging ?? "0",
                              mediaRating: argument.mediaRating ?? "0.0",
                              mediaGenre: argument.mediaGenre ?? "دراما",
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Container(
                              color: Colors.blue,
                              width: Get.width,
                              height: 300,
                              child: ContainedTabBarView(
                                tabBarViewProperties:
                                    const TabBarViewProperties(),
                                tabBarProperties: TabBarProperties(
                                    background: Container(
                                      color: Colors.black,
                                    ),
                                    indicatorColor: AppColors().blue,
                                    labelColor: AppColors().textandsearchcolor),
                                tabs: const [
                                  Text('نبذه عنا'),
                                  Text('ذات صله'),
                                  Text('الحلقات'),
                                ],
                                views: [
                                  Container(
                                    color: Colors.black,
                                    child: ListView(
                                      children: [
                                        const TextUtils(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          text: "وصف الفيلم  ",
                                          textalign: TextAlign.start,
                                        ),
                                        TextUtils(
                                          fontWeight: FontWeight.bold,
                                          color: AppColors().textandsearchcolor,
                                          text: argument.mediaDescription ??
                                              "mediaDescription",
                                          textalign: TextAlign.start,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    color: Colors.black,
                                    child: FutureBuilder(
                                      future:
                                          RelatedPosts(postID: argument.mediaID)
                                              .getData(),
                                      builder:
                                          (BuildContext context,
                                                  AsyncSnapshot snapshot) =>
                                              (snapshot.hasData)
                                                  ? Container(
                                                      height: 260,
                                                      decoration:
                                                          const BoxDecoration(),
                                                      child: Stack(
                                                        alignment:
                                                            Alignment.topRight,
                                                        children: [
                                                          ConstrainedBox(
                                                            constraints:
                                                                const BoxConstraints(
                                                                    maxHeight:
                                                                        400,
                                                                    minHeight:
                                                                        10.0),
                                                            child: ListView
                                                                .builder(
                                                                    itemCount:
                                                                        17,
                                                                    scrollDirection:
                                                                        Axis
                                                                            .horizontal,
                                                                    itemBuilder:
                                                                        ((context,
                                                                            index2) {
                                                                      return InkWell(
                                                                        onTap:
                                                                            () {
                                                                          print(
                                                                              snapshot.data);
                                                                          Get.to(
                                                                              MovieInfoScreen(),
                                                                              arguments: MediaControllerData(
                                                                                mediaID: snapshot.data[index2]["id"],
                                                                                mediaTitle: snapshot.data[index2]["title"],
                                                                                mediaImage: snapshot.data[index2]["thumbnailUrl"],
                                                                                mediaYear: "${snapshot.data[index2]['year']}",
                                                                              ));
                                                                        },
                                                                        child:
                                                                            GridViewBodyCard(
                                                                          title:
                                                                              snapshot.data[index2]["title"],
                                                                          imageUrl:
                                                                              snapshot.data[index2]["thumbnailUrl"],
                                                                        ),
                                                                      );
                                                                    })),
                                                          ),
                                                          const SizedBox(
                                                            height: 50,
                                                          )
                                                        ],
                                                      ),
                                                    )
                                                  : const Center(
                                                      child:
                                                          CircularProgressIndicator(),
                                                    ),
                                    ),
                                  ),
                                  Container(
                                      color: Colors.black,
                                      child: GridView.builder(
                                          itemCount: 30,
                                          padding: EdgeInsets.all(5),
                                          gridDelegate:
                                              const SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 2,
                                                  // childAspectRatio: 1,
                                                  crossAxisSpacing: 0,
                                                  mainAxisExtent: 30,
                                                  mainAxisSpacing: 20),
                                          itemBuilder: ((context, index) {
                                            return ListTile(
                                                leading: IconButton(
                                                    onPressed: () {},
                                                    icon: Icon(
                                                      Icons.play_arrow,
                                                      color: AppColors()
                                                          .textandsearchcolor,
                                                    )),
                                                title: Text("رقم الحلقه",
                                                    style: TextStyle(
                                                        color: AppColors()
                                                            .textandsearchcolor,
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.bold)));
                                          })))
                                ],
                                onChange: (index) => print(index),
                              ),
                            ),

                            // DetailsRow(),
                          ],
                        ),
                      ),
                    ]),
              ),
            )));
  }
}
