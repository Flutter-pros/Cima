import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/media_controller.dart';

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
    mediaController.filterData();
  }

  // bool isSeries = true;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.fromLTRB(10, 50, 10, 0),
        child: Obx(() {
          if (mediaController.media.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            print("mediaController.media***********: ${mediaController.media}");
            return GridView.builder(
              itemCount: mediaController
                  .media[mediaController.currentState.value].length,
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 250.0,
                childAspectRatio: 6 / 8,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
              ),
              itemBuilder: (_, index) {
                String imageURL = mediaController
                    .media[index][mediaController.currentState.value]
                    .mediaImage;
                String cleanImageURL;
                try {
                  cleanImageURL = (mediaController.isSeries.value)
                      ? imageURL.replaceAll(
                          imageURL.substring(
                              imageURL.indexOf(':', imageURL.indexOf(':') + 1),
                              imageURL.indexOf(r'/wp')),
                          "")
                      : imageURL;
                } catch (e) {
                  cleanImageURL = "images/failLoading/image_fail_loading.jpeg";
                }

                return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: bodyGridView(cleanImageURL,
                        "${mediaController.media[index][mediaController.currentState.value].mediaTitle}"));
              },
              cacheExtent: 100,
            );
          }
        }),
      ),
    );
  }

  Card bodyGridView(String imageUrl, String title) {
    const TextStyle textStyle = TextStyle(
        fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white);
    return Card(
      color: const Color(0xff5367ff).withOpacity(0.6),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 150,
            child: Image.network(
              fit: BoxFit.fill,
              imageUrl,
              errorBuilder: (BuildContext context, Object exception,
                  StackTrace? stackTrace) {
                return Image.asset(
                    "images/failLoading/image_fail_loading.jpeg");
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  title,
                  style: textStyle,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
