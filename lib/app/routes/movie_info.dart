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
                      SizedBox(
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
                              mediaGenre: argument.mediaGenre ?? "دراما",
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
                              text: argument.mediaDescription ??
                                  "mediaDescription",
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
                                                constraints:
                                                    const BoxConstraints(
                                                        maxHeight: 400,
                                                        minHeight: 10.0),
                                                child: ListView.builder(
                                                    itemCount: 17,
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    itemBuilder:
                                                        ((context, index2) {
                                                      return InkWell(
                                                        onTap: () {
                                                          print(snapshot.data);
                                                          Get.to(
                                                              MovieInfoScreen(),
                                                              arguments:
                                                                  MediaControllerData(
                                                                mediaID: snapshot
                                                                        .data[
                                                                    index2]["id"],
                                                                mediaTitle: snapshot
                                                                            .data[
                                                                        index2]
                                                                    ["title"],
                                                                mediaImage: snapshot
                                                                            .data[
                                                                        index2][
                                                                    "thumbnailUrl"],
                                                                mediaYear:
                                                                    "${snapshot.data[index2]['year']}",
                                                              ));
                                                        },
                                                        child: GridViewBodyCard(
                                                          title: snapshot
                                                                  .data[index2]
                                                              ["title"],
                                                          imageUrl: snapshot
                                                                  .data[index2]
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
                                        )
                                      : const Center(
                                          child: CircularProgressIndicator(),
                                        ),
                            )
                          ],
                        ),
                      ),
                    ]),
              ),
            )));
  }
}
