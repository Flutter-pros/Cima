import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cima/app/components/grid_view_body.dart';

import '../modules/HomePageBody/controllers/media_controller.dart';

class SearchInHome extends SearchDelegate {
  SearchInHome({required this.mediaController});
  final MediaController mediaController;
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: const Icon(Icons.close))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(Icons.arrow_back_ios));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.fromLTRB(10, 50, 10, 0),
        child: Obx(() {
          if (mediaController.media.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            // ignore: avoid_print

            return GridView.builder(
              itemCount: mediaController
                  .media[mediaController.currentState.value].length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2 / 3,
                crossAxisSpacing: 1,
                mainAxisSpacing: 1,
              ),
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              itemBuilder: (_, index) {
                String imageURL = mediaController
                    .media[mediaController.currentState.value][index]
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

                return GridViewBody(
                    imageUrl: cleanImageURL,
                    title:
                        "${mediaController.media[mediaController.currentState.value][index].mediaTitle}");
              },
            );
          }
        }),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const Center(
      child: Text(
        "Search",
        style: TextStyle(fontSize: 20, color: Colors.black),
      ),
    );
  }
}
