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
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                      height: Get.height * 0.4,
                      width: double.infinity,
                      child: const VideoPlayer()),
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
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        // color: Colors.grey.withOpacity(.1),
                      ),
                      height: 40,
                      width: 80,
                      child: Center(
                        child: TextUtils(
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                          text: argument.mediaDurationInMinutes ??
                              "0 0 0"
                                  "",
                          textalign: TextAlign.end,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        color: Colors.black.withOpacity(.1),
                      ),
                      height: 30,
                      width: MediaQuery.of(context).size.width / 1,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    DetailsRow(
                      mediaAging: argument.mediaAging ?? "0",
                      mediaRating: argument.mediaRating ?? "0.0",
                      mediaGenre: argument.mediaGenre ?? "mediaGenre",
                    ),
                    const SizedBox(
                      height: 5,
                    ),
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
                                          );
                                        })),
                                  ),
                                  const SizedBox(
                                    height: 50,
                                  )
                                ],
                              ),
                            ),
                          )
                        : const Center(
                            child: CircularProgressIndicator(),
                          ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
