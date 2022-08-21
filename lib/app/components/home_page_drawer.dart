import 'package:cima/app/data/movie_api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
//! we will use the HomepAgeBody controller (MediaController) to update the data in the home page body
import 'package:cima/app/modules/HomePageBody/controllers/media_controller.dart';
// import '../modules/Drawer/controllers/drawer_controller.dart' as drawer;

class HomePageDrawer extends StatefulWidget {
  const HomePageDrawer({Key? key}) : super(key: key);

  @override
  State<HomePageDrawer> createState() => _HomePageDrawerState();
}

class _HomePageDrawerState extends State<HomePageDrawer> {
  final MediaController mediaController = Get.put(MediaController());
  @override
  void initState() {
    super.initState();
  }

  List<Widget> icons = [
    const Icon(Icons.drive_file_move),
    const Icon(Icons.live_tv),
    const Icon(Icons.file_download),
    const Icon(Icons.live_tv),
    const Icon(Icons.search),
  ];
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: const Color.fromRGBO(14, 19, 49, 1),
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: ListView(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromRGBO(35, 40, 72, 1),
                ),
                child: TextFormField(
                  controller: searchController,
                  onFieldSubmitted: (value) {
                    mediaController.searchRemoteData(
                        search: value.trim().toLowerCase());
                    Get.back();
                  },
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Color.fromRGBO(35, 40, 72, 1),
                        ),
                      ),
                      hintStyle: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                          color: Colors.white),
                      hintText: '    إبحث فى ماي سيما',
                      prefixIcon: IconButton(
                        icon: const Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                        onPressed: () {},
                      )),
                ),
              ),
              FutureBuilder(
                  future: DrawerData().getData(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return Container(
                            //height: 70,
                            margin: const EdgeInsets.only(
                                top: 2, left: 10, right: 10, bottom: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color.fromRGBO(35, 40, 72, 1),
                            ),
                            child: ExpansionTile(
                              tilePadding: EdgeInsets.zero,
                              title: ListTile(
                                title: InkWell(
                                  onTap: () {
                                    // var updatedMediaController =
                                    //     MediaController();
                                    mediaController.filterData(
                                        termID: snapshot.data[index]["id"]);

                                    // mediaController.media.value =
                                    //     updatedMediaController.media;

                                    (index == 0)
                                        ? mediaController.isSeries.value = false
                                        : mediaController.isSeries.value = true;
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    "${snapshot.data[index]["name"]}",
                                    softWrap: false,
                                    overflow: TextOverflow.ellipsis,
                                    //  textAlign: TextAlign.right,
                                    style: const TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                              leading: ConstrainedBox(
                                constraints: const BoxConstraints(
                                  minWidth: 20,
                                  minHeight: 20,
                                  maxWidth: 20,
                                  maxHeight: 20,
                                ),
                                child: InkWell(onTap: () {}),
                              ),
                              children: [
                                ConstrainedBox(
                                  constraints: const BoxConstraints(
                                      maxHeight: 400, minHeight: 10.0),
                                  child: ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    //scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    //physics: const BouncingScrollPhysics(),
                                    itemCount:
                                        snapshot.data[index]["children"].length,
                                    itemBuilder: (context, index2) {
                                      final name = snapshot.data[index]
                                          ["children"][index2]["name"];
                                      return GestureDetector(
                                        onTap: () {
                                          mediaController.filterData(
                                              termID: snapshot.data[index]
                                                  ["children"][index2]["id"]);

                                          (index == 0)
                                              ? mediaController.isSeries.value =
                                                  false
                                              : mediaController.isSeries.value =
                                                  true;
                                          Navigator.pop(context);
                                        },
                                        child: ListTile(
                                          title: Text(
                                            name!,
                                            softWrap: false,
                                            overflow: TextOverflow.ellipsis,
                                            //textAlign: TextAlign.right,
                                            style: const TextStyle(
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    } else if (snapshot.hasError) {
                      // ignore: avoid_print
                      print(snapshot.error.toString());

                      return const Text('has error');
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  }),
            ],
          ),
        ));
  }
}

//title: "${snapshot.data[index]["name"]}",
//itemCount: snapshot.data[index]["children"].length,
//  var name =snapshot.data[index]["children"][index2]["name"];


  // onTap: () {
  //                               var updatedMediaController = MediaController();
  //                               updatedMediaController.filterData(
  //                                   termID: snapshot.data[index]["children"]
  //                                       [index2]["id"]);
      
  //                               mediaController.media.value =
  //                                   updatedMediaController.media;
      
  //                               (index == 0)
  //                                   ? mediaController.isSeries.value = false
  //                                   : mediaController.isSeries.value = true;
  //                               Navigator.pop(context);
  //                             },
  

  
  //   child: ListTile(
  //                               title: Text("$name"),
  //                             ),