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
  const MovieInfoScreen({
    Key? key,
  }) : super(key: key);
  @override
  State<MovieInfoScreen> createState() => _MovieInfoScreenState();
}

class _MovieInfoScreenState extends State<MovieInfoScreen> {
  final MediaControllerData argument = Get.arguments as MediaControllerData;
  final MediaController mediaController = Get.put(MediaController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: Colors.black,
      height: double.infinity,
      width: double.infinity,
      child: ListView(children: [
        Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(argument.mediaImage), fit: BoxFit.fill)),
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
                        Get.back();
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios_new_outlined,
                        color: Colors.white,
                      ))),
              Positioned(
                  child: CircleAvatar(
                radius: 35,
                backgroundColor: Colors.red,
                child: IconButton(
                    onPressed: () {
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
                  mediaAging: "${argument.mediaAging}",
                  mediaRating: "${argument.mediaRating}",
                  mediaGenre: "${argument.mediaGenre}",
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
            height: 900,

            // problem in high
            child: ContainedTabBarView(
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
                      Text(argument.mediaTitle,
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
                      Text("${argument.mediaGenre}",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 15)),
                      const SizedBox(
                        height: 7,
                      ),
                      Text("وصف الفيلم",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors().blue,
                              fontSize: 15)),
                      Text("${argument.mediaDescription}",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 15)),
                      const SizedBox(
                        height: 7,
                      ),
                      Text("الجوده",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors().blue,
                              fontSize: 15)),
                      Text("${argument.mediaQuality}",
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
                    future: RelatedPosts(postID: argument.mediaID).getData(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) =>
                        (snapshot.hasData)
                            ? Container(
                                decoration: const BoxDecoration(),
                                child: Stack(
                                  alignment: Alignment.topRight,
                                  children: [
                                    const SizedBox(
                                      height: 50,
                                    ),
                                    GridView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics()
                                                .parent,
                                        gridDelegate:
                                            const SliverGridDelegateWithMaxCrossAxisExtent(
                                                maxCrossAxisExtent: 200),
                                        itemCount: 17,
                                        scrollDirection: Axis.vertical,
                                        itemBuilder: ((context, index2) {
                                          return InkWell(
                                            onTap: () {
                                              print(snapshot.data);
                                              Get.to(const MovieInfoScreen(),
                                                  arguments:
                                                      MediaControllerData(
                                                    mediaID: snapshot
                                                        .data[index2]["id"],
                                                    mediaTitle: snapshot
                                                        .data[index2]["title"],
                                                    mediaImage:
                                                        snapshot.data[index2]
                                                            ["thumbnailUrl"],
                                                    mediaYear:
                                                        "${snapshot.data[index2]['year']}",
                                                  ));
                                            },
                                            child: GridViewBodyCard(
                                              title: snapshot.data[index2]
                                                  ["title"],
                                              imageUrl: snapshot.data[index2]
                                                  ["thumbnailUrl"],
                                            ),
                                          );
                                        }))
                                  ],
                                ),
                              )
                            : const Center(
                                child: CircularProgressIndicator(),
                              ),
                  ),
                ),
                Container(
                    color: Colors.black,
                    child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: argument.mediaEpisods ?? 18,
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
                                title: Text("الحلقه $index ",
                                    style: TextStyle(
                                        color: AppColors().textandsearchcolor,
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold))),
                          );
                        })))
              ],
              onChange: (index) => print(index),
            ),
          ),

          // DetailsRow(),
        ),
      ]),
    ));
  }
}
