import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cima/GetX/controllers/media_controller.dart';

class HomePageBody extends StatefulWidget {
  const HomePageBody({Key? key}) : super(key: key);

  @override
  State<HomePageBody> createState() => _HomePageBodyState();
}

class _HomePageBodyState extends State<HomePageBody> {
  bool isSeries = true;
  MediaController mediaController = MediaController.filteredDat();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.fromLTRB(10, 50, 10, 0),
        child: FutureBuilder(
            future: mediaController.filteredData,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return GridView.builder(
                  itemCount: snapshot.data.length,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 250.0,
                    childAspectRatio: 6 / 8,
                    mainAxisSpacing: 10.0,
                    crossAxisSpacing: 10.0,
                  ),
                  itemBuilder: (_, index) {
                    String imageURL = snapshot.data[index]["thumbnailUrl"];
                    String cleanImageURL;
                    try {
                      cleanImageURL = (isSeries)
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
                    }

                    return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: bodyGridView(
                            cleanImageURL, "${snapshot.data[index]["title"]}"));
                  },
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
