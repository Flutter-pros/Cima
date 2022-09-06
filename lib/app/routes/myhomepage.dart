import 'package:cima/app/modules/HomePageBody/controllers/media_controller.dart';
import 'package:cima/app/modules/HomePageBody/views/home_page_body.dart';
import 'package:cima/app/components/home_page_drawer.dart';
import 'package:cima/appcolors.dart';
import 'package:cima/appfont.dart';
import 'package:flutter/material.dart';
//import other screens preparation for the bottom navigation bar

import 'package:get/get.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  MediaController mediaController = Get.put(MediaController());
  bool isSearch = false;
  Widget searchOrClose = const Icon(Icons.search);
  Widget titleOrTextfield = Text(
    "سيما",
    style: TextStyle(
        color: AppColors().textandsearchcolor,
        fontSize: AppFonts().fontsizetext),
  );

  @override
  void initState() {
    super.initState();
    mediaController.filterData();
    mediaController.getDrawerData();
  }

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(14, 19, 49, 1),
      drawer: Obx(() => (mediaController.drawer.length > 1)
          ? const HomePageDrawer()
          : Container()),
      appBar: AppBar(
          actions: [
            Obx(() {
              if (mediaController.isPreviousActivated.value) {
                return IconButton(
                  icon: const Icon(Icons.arrow_forward),
                  onPressed: () {
                    mediaController.goPrevious();
                  },
                );
              } else {
                return Container();
              }
            }),
            IconButton(
              icon: searchOrClose,
              onPressed: () {
                setState(() {
                  isSearch = !isSearch;
                });
                if (isSearch) {
                  searchOrClose = const Icon(Icons.close);
                  titleOrTextfield = TextField(
                    autofocus: true,
                    style: const TextStyle(color: Colors.white),
                    controller: searchController,
                    onChanged: (search) {
                      if (search.trim().isNotEmpty) {
                        mediaController.searchLocalData(
                            search: searchController.text.trim());
                      }
                    },
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 25,
                        vertical: 4,
                      ),
                      hintText: 'اختر محتواك',
                      hintStyle: TextStyle(
                          color: AppColors().hinttext,
                          fontSize: AppFonts().fontsizehinttext),
                      prefixIcon: Icon(
                        Icons.search,
                        color: AppColors().textandsearchcolor,
                      ),
                    ),
                  );
                } else {
                  searchOrClose = IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        setState(
                          () {
                            titleOrTextfield = const Text("سيما");
                            searchController.clear();
                            mediaController.goPrevious();
                            searchOrClose = const Icon(Icons.search);
                          },
                        );
                      });
                }
              },
            ),
          ],
          centerTitle: true,
          title: titleOrTextfield,
          backgroundColor: const Color.fromRGBO(14, 19, 49, 1)),
      body: HomePageBody(),
    );
  }

  // ListView drawerNestedListTile(AsyncSnapshot<dynamic> snapshot, int index) {
  //   return ListView.builder(
  //       itemCount: snapshot.data[index]["children"].length,
  //       itemBuilder: (context, index2) {
  //         return ListTile(
  //           title: Text("${snapshot.data[index]["children"][index2]["name"]}"),
  //         );
  //       });
  // }

}
