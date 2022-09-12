import 'package:cima/app/modules/HomePageBody/controllers/media_controller.dart';
import 'package:cima/app/modules/HomePageBody/views/home_page_body.dart';
import 'package:cima/app/components/home_page_drawer.dart';
import 'package:cima/app/utils/appcolors.dart';
import 'package:cima/app/utils/appfont.dart';

import 'package:flutter/material.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';

//import other screens preparation for the bottom navigation bar

import 'package:get/get.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  MediaController mediaController = Get.put(MediaController());

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
    BackButtonInterceptor.add(myInterceptor);
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }

  Future<bool> myInterceptor(
      bool stopDefaultButtonEvent, RouteInfo info) async {
    final bool? shouldPop;
    if (mediaController.isFirstScreen.value) {
      if (!(mediaController.isPreviousActivated.value)) {
        shouldPop = await showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              backgroundColor: AppColors().appbackground,
              title: Text(
                'هل تريد الخروج من التطبيق؟',
                style: TextStyle(color: AppColors().textandsearchcolor),
              ),
              actionsAlignment: MainAxisAlignment.spaceBetween,
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: const Text('نعم'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                  child: const Text('لا'),
                ),
              ],
            );
          },
        );
      } else {
        mediaController.goPrevious();
        shouldPop = true;
      }
      return shouldPop!; // Do some stuff.
    } else {
      mediaController.isFirstScreen.value = true;
      return false;
    }
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
            IconButton(
              icon: searchOrClose,
              onPressed: () {
                setState(() {
                  mediaController.isSearchEnabled.value =
                      !mediaController.isSearchEnabled.value;
                  if (mediaController.isSearchEnabled.value) {
                    searchOrClose = const Icon(Icons.close);
                    titleOrTextfield = TextField(
                      autofocus: true,
                      style: const TextStyle(color: Colors.white),
                      controller: searchController,
                      onChanged: (search) {
                        if (search.trim().isNotEmpty) {
                          if (mediaController.media.length - 1 >
                              mediaController.targettedMediaState.value) {
                            mediaController.media.removeRange(
                                mediaController.targettedMediaState.value + 1,
                                mediaController.media.length);
                          }
                          mediaController.searchLocalData(
                              search: searchController.text.trim());
                        } else {
                          setState(() {
                            titleOrTextfield = const Text("سيما");
                            searchController.clear();
                            mediaController.goPrevious();
                            searchOrClose = const Icon(Icons.search);
                          });
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
                        icon: const Icon(Icons.search),
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
                    setState(() {
                      titleOrTextfield = const Text("سيما");
                      searchController.clear();
                      mediaController.goPrevious();
                      searchOrClose = const Icon(Icons.search);
                    });
                  }
                });
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
