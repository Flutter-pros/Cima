import 'package:cima/app/modules/HomePageBody/controllers/media_controller.dart';
import 'package:cima/app/modules/HomePageBody/views/home_page_body.dart';
import 'package:cima/app/components/home_page_drawer.dart';
import 'package:flutter/material.dart';
//import other screens preparation for the bottom navigation bar
import 'package:cima/app/routes/movie_info.dart';
import 'package:cima/app/routes/content.dart';
import 'package:get/get.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedPage = 0;
  MediaController mediaController = Get.put(MediaController());
  bool isSearch = false;
  Widget searchOrClose = const Icon(Icons.search);
  Widget titleOrTextfield = const Text("سيما");

  @override
  void initState() {
    super.initState();
    mediaController.filterData();
  }

  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      const HomePageBody(),
      const MovienfoScreen(),
      const Content(),
    ];

    return Scaffold(
      backgroundColor: const Color.fromRGBO(14, 19, 49, 1),
      drawer: const HomePageDrawer(),
      appBar: AppBar(
          actions: [
            Obx(() {
              if (mediaController.isPreviousActivated.value &&
                  _selectedPage == 0) {
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
            (_selectedPage == 0)
                ? IconButton(
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
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 25,
                              vertical: 4,
                            ),
                            hintText: 'اختر محتواك',
                            hintStyle: TextStyle(color: Colors.white),
                            prefixIcon: Icon(Icons.search),
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
                  )
                : Container(),
          ],
          centerTitle: true,
          title: titleOrTextfield,
          backgroundColor: const Color.fromRGBO(14, 19, 49, 1)),
      body: pages[_selectedPage],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromRGBO(14, 19, 49, 1),
        unselectedItemColor: Colors.white54,
        selectedItemColor: Colors.white,
        currentIndex: _selectedPage,
        onTap: (int index) {
          setState(() {
            _selectedPage = index;
          });
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: 'القائمة',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'حول',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.video_library),
            label: 'مشاهدة وتحميل',
          ),
        ],
      ),
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
