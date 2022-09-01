import 'package:cima/app/components/grid_view_body_card.dart';
import 'package:cima/app/data/movie_api.dart';
import 'package:cima/app/modules/HomePageBody/controllers/media_controller.dart';
import 'package:cima/app/utils/iconbuttonutils.dart';
import 'package:cima/app/components/row_and_details.dart';
import 'package:cima/app/utils/textutils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MovieInfoScreen extends StatelessWidget {
  const MovieInfoScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MediaControllerData argument =
        ModalRoute.of(context)!.settings.arguments as MediaControllerData;

    return Scaffold(
      body: Container(
        color: Colors.black,
        height: double.infinity,
        width: double.infinity,
        child: ListView(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: 250,
                  width: MediaQuery.of(context).size.width / 1,
                  child: Image.network(
                    argument.mediaImage,
                    fit: BoxFit.fill,
                  ),
                ),
                Positioned(
                    right: 2,
                    top: 5,
                    child: IconButtonUtils(
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                        onprassed: () {
                          Get.back();
                        })),
                Positioned(
                  child: CircleAvatar(
                      maxRadius: 30,
                      backgroundColor: Colors.black,
                      child: IconButtonUtils(
                          icon: const Icon(
                            Icons.play_arrow,
                            color: Colors.white,
                          ),
                          onprassed: () {
                            Get.toNamed('/movieplayer', arguments: {
                              "watch___URL": argument.mediaWatchURL,
                              "downloads": argument.mediaDownloads
                            });
                          })),
                ),
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
                        text: argument.mediaDurationInMinutes!,
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
                    mediaAging: argument.mediaAging!,
                    mediaRating: argument.mediaRating!,
                    mediaGenre: argument.mediaGenre!,
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
            Container(
              margin: const EdgeInsets.only(right: 20, left: 20),
              child: Column(
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
                    text: argument.mediaDescription!,
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
                                ListView.builder(
                                    itemCount: 17,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: ((context, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          Get.toNamed('/movieinfo',
                                              arguments: MediaControllerData(
                                                mediaID: snapshot.data[index]
                                                    ["id"],
                                                mediaTitle: snapshot.data[index]
                                                    ["title"],
                                                mediaImage: snapshot.data[index]
                                                    ["thumbnailUrl"],
                                                mediaYear:
                                                    snapshot.data['year'],
                                              ).getMoreDetails());
                                        },
                                        child: GridViewBodyCard(
                                          title: snapshot.data[index]["title"],
                                          imageUrl: snapshot.data[index]
                                              ["thumbnailUrl"],
                                        ),
                                      );
                                    })),
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
    );
  }
}
