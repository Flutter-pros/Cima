import 'package:cima/app/components/home_page_filters.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/media_controller.dart';
import 'package:cima/app/components/grid_view_body.dart';

class HomePageBody extends StatefulWidget {
  const HomePageBody({Key? key}) : super(key: key);

  @override
  State<HomePageBody> createState() => _HomePageBodyState();
}

class _HomePageBodyState extends State<HomePageBody> {
  final MediaController mediaController = Get.put(MediaController());
  @override
  void initState() {
    super.initState();
  }

  // bool isSeries = true;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(10, 50, 10, 0),
            child: SingleChildScrollView(
              child: Obx(() {
                ImageCache imageCache = ImageCache();
                imageCache.clear();
                imageCache.clearLiveImages();
                print(
                    "mediaController.media.value: ${mediaController.media.value}");
                print(
                    "mediaController.isPreviousActivated.value: ${mediaController.isPreviousActivated.value}");
                print(
                    "mediaController.media.length: ${mediaController.media.value.length}");
                if (mediaController.media.isEmpty) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  // ignore: avoid_print

                  return GridView.builder(
                    itemCount: mediaController.media.last.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
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

                      return GridViewBody(
                          imageUrl: imageURL,
                          title:
                              "${mediaController.media.last[index].mediaTitle}");
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
                  child: const HomePageFilters())
              : Container()),
        ],
      ),
    );
  }
}
