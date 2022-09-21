import 'package:cima/app/data/movie_api.dart';
import 'package:cima/app/modules/HomePageBody/controllers/media_controller.dart';
import 'package:cima/app/routes/movie_info.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:cima/app/components/grid_view_body_card.dart';
import 'package:cima/app/components/shimmer.dart';
import 'package:cima/app/components/video_player.dart';
import 'package:cima/app/utils/appcolors.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:get/get.dart';
import 'package:cima/app/library/globals.dart' as globals;

// ignore: must_be_immutable
class MovieInfoFutureBuilder extends StatefulWidget {
  MovieInfoFutureBuilder(
      {Key? key, required this.snapshotData, required this.arguments})
      : super(key: key);

  // ignore: prefer_typing_uninitialized_variables
  var snapshotData;
  final MediaControllerData arguments;
  @override
  // ignore: library_private_types_in_public_api
  _MovieInfoFutureBuilderState createState() => _MovieInfoFutureBuilderState();
}

class _MovieInfoFutureBuilderState extends State<MovieInfoFutureBuilder> {
  List episodsData = [];
  Map<String, dynamic>? data;
  List<double> tabsSize = [Get.height, 1100, 700];
  int tabsIndex = 0;
  int episodNumber = 1;
  List genres = [];
  List mpaas = [];
  List qualities = [];
  List<Text> tabs = [];
  List<Container> views = [];
  final MediaController mediaController = Get.put(MediaController());

  @override
  void initState() {
    super.initState();

    if (globals.isSeries) {
      episodsData = widget.snapshotData as List;
    } else {
      data = widget.snapshotData;
    }
    genres = (data != null)
        ? (data!["genre"].map((e) => e["name"]).toList())
        : ["دراما"];

    mpaas = (data != null)
        ? (data!["mpaa"].map((e) => e["name"]).toList())
        : ["tv-14"];
    qualities = (data != null)
        ? (data!["Quality"].map((e) => e["name"]).toList())
        : ["720p"];
  }

  @override
  Widget build(BuildContext context) {
    var nestedScrollView = NestedScrollView(
        headerSliverBuilder: ((context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
                backgroundColor: Colors.black,
                expandedHeight: 300,
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                      alignment: Alignment.centerRight,
                      fit: StackFit.passthrough,
                      children: [
                        Image.network(
                          widget.arguments.mediaImage,
                          fit: BoxFit.fill,
                        ),
                        Center(
                          child: Positioned(
                              child: CircleAvatar(
                            radius: 35,
                            backgroundColor: Colors.red,
                            child: IconButton(
                                onPressed: () {
                                  Get.to(() => SamplePlayer(
                                        url: data!["watch_url"],
                                      ));
                                },
                                icon: Icon(
                                  Icons.play_arrow_outlined,
                                  color: AppColors().textandsearchcolor,
                                )),
                          )),
                        ),
                        Positioned(
                            bottom: 0,
                            height: 100,
                            width: Get.width,
                            child: Container(
                                decoration: BoxDecoration(boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(.2),
                                  blurRadius: 100,
                                  spreadRadius: 50,
                                  offset: const Offset(-10, 5)),
                              BoxShadow(
                                  color: Colors.black.withOpacity(.2),
                                  blurRadius: 100,
                                  spreadRadius: 50,
                                  offset: const Offset(-10, 7)),
                              BoxShadow(
                                  color: Colors.black.withOpacity(.3),
                                  blurRadius: 100,
                                  spreadRadius: 50,
                                  offset: const Offset(-10, 10)),
                              BoxShadow(
                                  color: Colors.black.withOpacity(.4),
                                  blurRadius: 100,
                                  spreadRadius: 50,
                                  offset: const Offset(-10, 13)),
                              BoxShadow(
                                  color: Colors.black.withOpacity(.4),
                                  blurRadius: 100,
                                  spreadRadius: 50,
                                  offset: const Offset(-2, 17))
                            ]))),
                        Positioned(
                            bottom: 0,
                            child: SizedBox(
                              height: 40,
                              width: Get.width,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          (data != null)
                                              ? "${data!["imdbRating"]}"
                                              : "0.0",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: AppColors()
                                                  .textandsearchcolor),
                                        ),
                                        const Icon(
                                          Icons.star,
                                          color: Colors.yellow,
                                          size: 20,
                                        )
                                      ]),
                                  Text(
                                    (genres.isNotEmpty) ? genres[0] : "دراما",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: AppColors().textandsearchcolor),
                                  ),
                                  Text(
                                    (mpaas.isNotEmpty) ? mpaas[0] : "tv-14",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: AppColors().textandsearchcolor),
                                  ),
                                ],
                              ),
                            ))
                      ]),
                ),
                leading: Container(),
                actions: [
                  IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios_new_outlined,
                      )),
                ])
          ];
        }),
        body: ListView(children: [
          const SizedBox(
            height: 15,
          ),
          (globals.isSeries)
              ? Row(
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
                          onPressed: () {
                            if (episodNumber < episodsData.length) {
                              setState(() {
                                episodNumber++;
                                tabsIndex = 2;
                              });
                            }
                          },
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
                          onPressed: () {
                            if (episodNumber > 1) {
                              setState(() {
                                episodNumber--;
                                tabsIndex = 2;
                              });
                            }
                          },
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
                )
              : Container(),
          const SizedBox(
            height: 10,
            // DetailsRow(),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),

            child: Container(
              color: Colors.blue,
              width: Get.width,
              height: tabsSize[tabsIndex],

              // problem in high
              child: ContainedTabBarView(
                initialIndex: tabsIndex,
                // callOnChangeWhileIndexIsChanging: true,
                onChange: (index) {
                  if (kDebugMode) {
                    print("****tabsIndex:$index****");
                  }
                  setState(() {
                    tabsSize[2] =
                        ((data != null) ? data!["series"].length : 17.0) * 42.0;
                    tabsIndex = index;
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
                tabs: (globals.isSeries)
                    ? const [
                        Text('نبذه عنا'),
                        Text('ذات صله'),
                        Text('الحلقات'),
                      ]
                    : const [
                        Text('نبذه عنا'),
                        Text('ذات صله'),
                      ],
                views: (globals.isSeries)
                    ? [
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
                              Text(genres.join(", "),
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
                              Text((data != null) ? data!["story"] : "",
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
                              Text(qualities.join(", "),
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
                            future:
                                RelatedPosts(postID: widget.arguments.mediaID)
                                    .getData(),
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
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
                                              closedColor:
                                                  AppColors().appbackground,
                                              closedBuilder:
                                                  (_, closedBuilder) =>
                                                      GridViewBodyCard(
                                                title: snapshot.data[index2]
                                                    ["title"],
                                                imageUrl: snapshot.data[index2]
                                                    ["thumbnailUrl"],
                                              ),
                                              openBuilder: (_, openBuilder) {
                                                return MovieInfoScreen(
                                                    arguments:
                                                        MediaControllerData(
                                                  mediaID: snapshot.data[index2]
                                                      ["id"],
                                                  mediaTitle: snapshot
                                                      .data[index2]["title"],
                                                  mediaImage:
                                                      snapshot.data[index2]
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
                                return const MediaShimmer();
                              }
                            },
                          ),
                        ),
                        Container(
                            color: Colors.black,
                            child: GridView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: episodsData.length,
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
                                      color:
                                          const Color.fromRGBO(35, 40, 72, 1),
                                    ),
                                    child: ListTile(
                                        leading: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                episodNumber = index + 1;
                                              });
                                            },
                                            icon: Icon(
                                              Icons.play_arrow,
                                              color: AppColors()
                                                  .textandsearchcolor,
                                            )),
                                        title: Text("الحلقه ${index + 1} ",
                                            style: TextStyle(
                                                color: AppColors()
                                                    .textandsearchcolor,
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold))),
                                  );
                                })))
                      ]
                    : [
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
                              Text(genres.join(", "),
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
                              Text((data != null) ? data!["story"] : "",
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
                              Text(qualities.join(", "),
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
                            future:
                                RelatedPosts(postID: widget.arguments.mediaID)
                                    .getData(),
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
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
                                              closedColor:
                                                  AppColors().appbackground,
                                              closedBuilder:
                                                  (_, closedBuilder) =>
                                                      GridViewBodyCard(
                                                title: snapshot.data[index2]
                                                    ["title"],
                                                imageUrl: snapshot.data[index2]
                                                    ["thumbnailUrl"],
                                              ),
                                              openBuilder: (_, openBuilder) {
                                                return MovieInfoScreen(
                                                    arguments:
                                                        MediaControllerData(
                                                  mediaID: snapshot.data[index2]
                                                      ["id"],
                                                  mediaTitle: snapshot
                                                      .data[index2]["title"],
                                                  mediaImage:
                                                      snapshot.data[index2]
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
                                return const MediaShimmer();
                              }
                            },
                          ),
                        ),
                      ],
              ),
            ),
            // DetailsRow(),
          ),
        ]));
    return (globals.isSeries)
        ? FutureBuilder(
            future: MediaData(
                    mediaID: episodsData[episodsData.length - episodNumber]
                        ["id"])
                .getData(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (kDebugMode) {
                  print("$episodNumber");
                }
                data = snapshot.data as Map<String, dynamic>;
                genres = data!["genre"].map((e) => e["name"]).toList();
                mpaas = data!["mpaa"].map((e) => e["name"]).toList();
                qualities = data!["Quality"].map((e) => e["name"]).toList();
                return nestedScrollView;
              } else {
                return nestedScrollView;
              }
            })
        : nestedScrollView;
  }
}
