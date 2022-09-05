import 'package:cima/app/components/grid_view_body_card.dart';
import 'package:cima/app/components/video_player.dart';
import 'package:cima/app/data/movie_api.dart';
import 'package:cima/app/modules/HomePageBody/controllers/media_controller.dart';

import 'package:cima/app/components/row_and_details.dart';
import 'package:cima/app/utils/textutils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MovieInfoScreen extends StatelessWidget {
  MovieInfoScreen({
    Key? key,
  }) : super(key: key);
  final MediaController mediaController = Get.put(MediaController());

  @override
  Widget build(BuildContext context) {
    final MediaControllerData argument =
        mediaController.media.last[mediaController.mediaIndex.value];

    return Scaffold(
        body: Container(
            color: Colors.black,
            height: double.infinity,
            width: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: Get.height * .4,
                      width: Get.width,
                      child: Stack(
                        children: [
                          const VideoPlayer(),
                          Positioned(
                              top: 36,
                              left: 10,
                              child: IconButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  icon: const Icon(
                                    Icons.arrow_back_ios_new_outlined,
                                    color: Colors.white,
                                  )))
                          // Positioned(
                          //   child: CircleAvatar(
                          //       maxRadius: 30,
                          //       backgroundColor: Colors.black,
                          //       child: IconButton(
                          //         onPressed: () {
                          //           Get.toNamed('/content', arguments: {
                          //             "watch___URL": argument.mediaWatchURL,
                          //             "downloads": argument.mediaDownloads
                          //           });
                          //         },
                          //         icon: const Icon(
                          //           Icons.play_arrow,
                          //           color: Colors.white,
                          //         ),
                          //       )),
                          // ),
                          // Positioned(
                          //   bottom: 0,
                          //   right: 0,
                          //   child: Container(
                          //     decoration: BoxDecoration(
                          //       borderRadius: BorderRadius.circular(7),
                          //       // color: Colors.grey.withOpacity(.1),
                          //     ),
                          //     height: 40,
                          //     width: 80,
                          //     child: Center(
                          //       child: TextUtils(
                          //         color: Colors.white,
                          //         fontWeight: FontWeight.normal,
                          //         text: argument.mediaDurationInMinutes ??
                          //             "0 0 0"
                          //                 "",
                          //         textalign: TextAlign.end,
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          // Positioned(
                          //   bottom: 0,
                          //   child: Container(
                          //     decoration: BoxDecoration(
                          //       borderRadius: BorderRadius.circular(7),
                          //       color: Colors.black.withOpacity(.1),
                          //     ),
                          //     height: 30,
                          //     width: MediaQuery.of(context).size.width / 1,
                          //   ),
                          // )
                        ],
                      ),
                    ),
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
                            mediaGenre: argument.mediaGenre ?? "mediaGenre",
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          ExpansionTile(
                            tilePadding:
                                const EdgeInsets.symmetric(horizontal: 15),
                            title: const TextUtils(
                                text: "الحلقات",
                                textalign: TextAlign.start,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                            children: [
                              ListTile(
                                leading: IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.play_arrow,
                                      color: Colors.white,
                                    )),
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const TextUtils(
                                        text: "اسم الحلقه",
                                        textalign: TextAlign.start,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                    Container(
                                      height: 50,
                                      width: Get.width / 5,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          image: const DecorationImage(
                                              image: NetworkImage(
                                                  'https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=465&q=80'),
                                              fit: BoxFit.cover)),
                                    )
                                  ],
                                ),
                                trailing: IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.download,
                                      color: Colors.white,
                                    )),
                              )
                            ],
                          ),
                          // DetailsRow(),

                          const TextUtils(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            text: "وصف الفيلم  ",
                            textalign: TextAlign.end,
                          ),
                          TextUtils(
                            fontWeight: FontWeight.normal,
                            color: Colors.white,
                            text:
                                argument.mediaDescription ?? "mediaDescription",
                            textalign: TextAlign.end,
                          ),
                          const TextUtils(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            text: "ذات صله ",
                            textalign: TextAlign.end,
                          ),
                          FutureBuilder(
                            future: RelatedPosts(postID: argument.mediaID)
                                .getData(),
                            builder: (BuildContext context,
                                    AsyncSnapshot snapshot) =>
                                (snapshot.hasData)
                                    ? Container(
                                        height: 260,
                                        decoration: const BoxDecoration(),
                                        child: Stack(
                                          alignment: Alignment.topRight,
                                          children: [
                                            ConstrainedBox(
                                              constraints: const BoxConstraints(
                                                  maxHeight: 400,
                                                  minHeight: 10.0),
                                              child: ListView.builder(
                                                  itemCount: 17,
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  itemBuilder:
                                                      ((context, index) {
                                                    return GestureDetector(
                                                      onTap: () {
                                                        Get.toNamed(
                                                            '/movieinfo',
                                                            arguments:
                                                                MediaControllerData(
                                                              mediaID: snapshot
                                                                      .data[
                                                                  index]["id"],
                                                              mediaTitle:
                                                                  snapshot.data[
                                                                          index]
                                                                      ["title"],
                                                              mediaImage: snapshot
                                                                          .data[
                                                                      index][
                                                                  "thumbnailUrl"],
                                                              mediaYear:
                                                                  "${snapshot.data['year']}",
                                                            ).getMoreDetails());
                                                      },
                                                      child: GridViewBodyCard(
                                                        title:
                                                            snapshot.data[index]
                                                                ["title"],
                                                        imageUrl: snapshot
                                                                .data[index]
                                                            ["thumbnailUrl"],
                                                      ),
                                                    );
                                                  })),

                    // DetailsRow(),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  const TextUtils(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    text: "وصف الفيلم  ",
                    textalign: TextAlign.end,
                  ),
                  TextUtils(
                    fontWeight: FontWeight.normal,
                    color: Colors.white,
                    text: argument.mediaDescription ?? "mediaDescription",
                    textalign: TextAlign.end,
                  ),
                  const TextUtils(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    text: "ذات صله ",
                    textalign: TextAlign.end,
                  ),
                ],
              ),
              FutureBuilder(
                future: RelatedPosts(postID: argument.mediaID).getData(),
                builder: (BuildContext context, AsyncSnapshot snapshot) =>
                    (snapshot.hasData)
                        ? SizedBox(
                            height: 200,
                            child: Container(
                              decoration: const BoxDecoration(),
                              child: Stack(
                                alignment: Alignment.topRight,
                                children: [
                                  ConstrainedBox(
                                    constraints: const BoxConstraints(
                                        maxHeight: 400, minHeight: 10.0),
                                    child: ListView.builder(
                                        itemCount: 17,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: ((context, index) {
                                          return GestureDetector(
                                            onTap: () {
                                              mediaController.mediaIndex.value =
                                                  index;
                                              Get.to(() => MovieInfoScreen());
                                            },
                                            child: GridViewBodyCard(
                                              title: snapshot.data[index]
                                                  ["title"],
                                              imageUrl: snapshot.data[index]
                                                  ["thumbnailUrl"],

                                            ),
                                            const SizedBox(
                                              height: 50,
                                            )
                                          ],
                                        ),
                                      )
                                    : const Center(
                                        child: CircularProgressIndicator(),
                                      ),
                          )
                        ],
                      ),
                    ),
                  ]),
            )));
  }
}
