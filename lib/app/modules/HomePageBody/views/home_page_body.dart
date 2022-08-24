import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/media_controller.dart';
import 'package:cima/app/components/grid_view_body.dart';
import 'package:chips_choice_null_safety/chips_choice_null_safety.dart';

class HomePageBody extends StatefulWidget {
  const HomePageBody({Key? key}) : super(key: key);

  @override
  State<HomePageBody> createState() => _HomePageBodyState();
}

class _HomePageBodyState extends State<HomePageBody> {
  final MediaController mediaController = Get.put(MediaController());
  List<String> filters = [];
  @override
  void initState() {
    super.initState();
    filters.addAll(mediaController.getFilters());
    print(filters);
  }

  int tag = 1;

  // bool isSeries = true;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Obx(() {
              if (mediaController.media.isNotEmpty) {
                return ChipsChoice<int>.single(
                  choiceStyle: C2ChoiceStyle(
                    backgroundColor: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    borderColor: Colors.grey,
                    borderWidth: 1,
                    color: Colors.grey,
                    // padding: const EdgeInsets.all(10),
                  ),
                  value: tag,
                  onChanged: (val) => setState(() => tag = val),
                  choiceItems: C2Choice.listFrom<int, String>(
                    source: filters,
                    value: (i, v) => i,
                    label: (i, v) => v,
                  ),
                );
              } else {
                return Container();
              }
            }),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 50, 10, 0),
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
                      String cleanImageURL;
                      try {
                        cleanImageURL = (mediaController.isSeries.value)
                            ? imageURL.replaceAll(
                                imageURL.substring(
                                    imageURL.indexOf(
                                        ':', imageURL.indexOf(':') + 1),
                                    imageURL.indexOf(r'/wp')),
                                "")
                            : imageURL;
                      } catch (e) {
                        cleanImageURL =
                            "images/failLoading/image_fail_loading.jpeg";
                        print(cleanImageURL);
                      }

                      return GridViewBody(
                          imageUrl: cleanImageURL,
                          title:
                              "${mediaController.media.last[index].mediaTitle}");
                    },
                  );
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}
