import 'package:animations/animations.dart';
import 'package:cima/app/components/grid_view_body_card.dart';
import 'package:cima/app/components/video_player.dart';
import 'package:cima/app/data/movie_api.dart';
import 'package:cima/app/modules/HomePageBody/controllers/media_controller.dart';
import 'package:cima/app/components/row_and_details.dart';
import 'package:cima/app/utils/appcolors.dart';

// import 'package:cima/appcolors.dart';

import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MovieInfoScreen extends StatefulWidget {
  const MovieInfoScreen({Key? key, required this.arguments}) : super(key: key);
  final MediaControllerData arguments;
  @override
  State<MovieInfoScreen> createState() => _MovieInfoScreenState();
}

class _MovieInfoScreenState extends State<MovieInfoScreen> {
  // final MediaControllerData argument = Get.arguments as MediaControllerData;
  final MediaController mediaController = Get.put(MediaController());
  List<double> tabsSize = [400, 1100, 700];
  int tabsindex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future: widget.arguments.getMoreDetails(),
      builder: (_, snapshot) => Container(
        color: Colors.black,
        height: double.infinity,
        width: double.infinity,
        child: ListView(children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(widget.arguments.mediaImage),
                    fit: BoxFit.fill)),
            height: 280,
            width: Get.width * .5,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                    top: 38,
                    left: 10,
                    child: IconButton(
                        onPressed: () {
                          mediaController.isFirstScreen.value = true;
                          Get.back();
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios_new_outlined,
                          color: Colors.white,
                          shadows: [
                            Shadow(color: Colors.black, blurRadius: 20)
                          ],
                        ))),
                Positioned(
                    child: CircleAvatar(
                  radius: 35,
                  backgroundColor: Colors.red,
                  child: IconButton(
                      onPressed: () {
                        mediaController.isFirstScreen.value = false;

                        Get.to(() => const VideoPlayer());
                      },
                      icon: Icon(
                        Icons.play_arrow_outlined,
                        color: AppColors().textandsearchcolor,
                      )),
                )),
                Positioned(
                  bottom: 0,
                  child: DetailsRow(
                    mediaAging: "${widget.arguments.mediaAging}",
                    mediaRating: "${widget.arguments.mediaRating}",
                    mediaGenre: "${widget.arguments.mediaGenre}",
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromRGBO(35, 40, 72, 1),
                ),
                margin: const EdgeInsets.only(
                  left: 10,
                  right: 10,
                ),
                height: 40,
                width: Get.width * .4,
                child: TextButton(
                    onPressed: () {},
                    child: Text(
                      "الحلقه التاليه",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: AppColors().textandsearchcolor,
                      ),
                    )),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromRGBO(35, 40, 72, 1),
                ),
                margin: const EdgeInsets.only(
                  left: 10,
                  right: 10,
                ),
                height: 40,
                width: Get.width * .4,
                child: TextButton(
                    onPressed: () {},
                    child: Text(
                      "الحلقه السابقه",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: AppColors().textandsearchcolor,
                      ),
                    )),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),

            child: Container(
              color: Colors.blue,
              width: Get.width,
              height: tabsSize[tabsindex],

              // problem in high
              child: ContainedTabBarView(
                initialIndex: tabsindex,
                callOnChangeWhileIndexIsChanging: true,
                onChange: (index) {
                  setState(() {
                    tabsSize[2] =
                        (widget.arguments.mediaEpisods ?? 17.0) * 42.0;

                    tabsindex = index;
                  });
                },
                tabBarViewProperties: const TabBarViewProperties(
                    physics: NeverScrollableScrollPhysics()),
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
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        Text("الاسم",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors().blue,
                                fontSize: 15)),
                        Text(widget.arguments.mediaTitle,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 15)),
                        const SizedBox(
                          height: 7,
                        ),
                        Text("النوع",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors().blue,
                                fontSize: 15)),
                        Text("${widget.arguments.mediaGenre}",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 15)),
                        const SizedBox(
                          height: 7,
                        ),
                        Text("القصة",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors().blue,
                                fontSize: 15)),
                        Text("${widget.arguments.mediaDescription}",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 15)),
                        const SizedBox(
                          height: 7,
                        ),
                        Text("الجودة",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors().blue,
                                fontSize: 15)),
                        Text("${widget.arguments.mediaQuality}",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 15)),
                        const SizedBox(
                          height: 7,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.black,
                    child: FutureBuilder(
                      future: RelatedPosts(postID: widget.arguments.mediaID)
                          .getData(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          tabsSize[1] = snapshot.data.length * 128.0;

                          return Container(
                            decoration: const BoxDecoration(),
                            child: Stack(
                              alignment: Alignment.topRight,
                              children: [
                                const SizedBox(
                                  height: 50,
                                ),
                                GridView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    gridDelegate:
                                        const SliverGridDelegateWithMaxCrossAxisExtent(
                                            mainAxisExtent: 250,
                                            maxCrossAxisExtent: 300),
                                    itemCount: snapshot.data.length,
                                    scrollDirection: Axis.vertical,
                                    itemBuilder: ((context, index2) {
                                      return OpenContainer(
                                        closedColor: AppColors().appbackground,
                                        closedBuilder: (_, closedBuilder) =>
                                            GridViewBodyCard(
                                          title: snapshot.data[index2]["title"],
                                          imageUrl: snapshot.data[index2]
                                              ["thumbnailUrl"],
                                        ),
                                        openBuilder: (_, openBuilder) {
                                          // mediaController.isFirstScreen.value =
                                          //     false;
                                          // // Get.toNamed("/movie_info",
                                          // //     arguments: mediaController.media.last[index]);
                                          // return MovieInfoScreen(
                                          //     arguments: mediaController
                                          //         .media.last[index]);
                                          return MovieInfoScreen(
                                              arguments: MediaControllerData(
                                            mediaID: snapshot.data[index2]
                                                ["id"],
                                            mediaTitle: snapshot.data[index2]
                                                ["title"],
                                            mediaImage: snapshot.data[index2]
                                                ["thumbnailUrl"],
                                            mediaYear:
                                                "${snapshot.data[index2]['year']}",
                                          ));
                                        },
                                      );
                                    }))
                              ],
                            ),
                          );
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
                  ),
                  Container(
                      color: Colors.black,
                      child: GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: widget.arguments.mediaEpisods ?? 18,
                          padding: const EdgeInsets.all(5),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 3,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 20),
                          itemBuilder: ((context, index) {
                            return Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color.fromRGBO(35, 40, 72, 1),
                              ),
                              child: ListTile(
                                  leading: IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.play_arrow,
                                        color: AppColors().textandsearchcolor,
                                      )),
                                  title: Text("الحلقه ${index + 1} ",
                                      style: TextStyle(
                                          color: AppColors().textandsearchcolor,
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold))),
                            );
                          })))
                ],
              ),
            ),

            // DetailsRow(),
          ),
        ]),
      ),
    ));
  }
}
