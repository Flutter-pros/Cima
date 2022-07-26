import 'package:cima/app/components/home_page_filters.dart';
import 'package:cima/app/routes/movie_info.dart';
import 'package:cima/app/utils/appcolors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/media_controller.dart';
import 'package:cima/app/components/grid_view_body_card.dart';
import "package:animations/animations.dart";
import 'package:cima/app/components/shimmer.dart';
import 'package:cima/app/library/globals.dart' as globals;

class HomePageBody extends StatelessWidget {
  HomePageBody({Key? key}) : super(key: key);
  final MediaController mediaController = Get.put(MediaController());

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(10, 50, 10, 0),
          child: SingleChildScrollView(
            child: Obx(() {
              ImageCache imageCache = ImageCache();
              imageCache.clear();
              imageCache.clearLiveImages();
              if (kDebugMode) {
                print("mediaController.media.value: ${mediaController.media}");
                print(
                    "mediaController.isPreviousActivated.value: ${mediaController.isPreviousActivated.value}");
                print(
                    "mediaController.media.length: ${mediaController.media.length}");
                print(
                    "mediaController.targettedMediaState: ${mediaController.targettedMediaState.value}");
              }

              if (mediaController.media.isEmpty) {
                return const MediaShimmer();
              } else {
                // ignore: avoid_print

                return GridView.builder(
                  itemCount: mediaController.media.last.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 2 / 3,
                    crossAxisSpacing: 1,
                    mainAxisSpacing: 1,
                  ),
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  itemBuilder: (_, index) {
                    String imageURL =
                        mediaController.media.last[index].mediaImage;

                    try {
                      mediaController.media.last[index].mediaImage =
                          (globals.isSeries)
                              ? mediaController.media.last[index].mediaImage
                                  .replaceAll(
                                      imageURL.substring(
                                          imageURL.indexOf(
                                              ':', imageURL.indexOf(':') + 1),
                                          imageURL.indexOf(r'/wp')),
                                      "")
                              : imageURL;
                    } catch (e) {
                      mediaController.media.last[index].mediaImage =
                          "images/failLoading/image_fail_loading.jpeg";
                    }

                    return OpenContainer(
                      closedColor: AppColors().appbackground,
                      closedBuilder: (_, closedBuilder) => GridViewBodyCard(
                          imageUrl:
                              mediaController.media.last[index].mediaImage,
                          title:
                              "${mediaController.media.last[index].mediaTitle}"),
                      openBuilder: (_, openBuilder) {
                        mediaController.isFirstScreen.value = false;
                        // Get.toNamed("/movie_info",
                        //     arguments: mediaController.media.last[index]);
                        return MovieInfoScreen(
                            arguments: mediaController.media.last[index]);
                      },
                    );
                  },
                );
              }
            }),
          ),
        ),
        Obx(() => (mediaController.media.isNotEmpty)
            ? SizedBox(
                height: (mediaController.isAnyFilterExpanded.value)
                    ? MediaQuery.of(context).size.height / 2
                    : 50,
                child: HomePageFilters())
            : Container()),
      ],
    );
  }
}




  // bool isSeries = true;



