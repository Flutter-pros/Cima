import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cima/GetX/controllers/movieController.dart';
import 'package:getwidget/components/accordion/gf_accordion.dart';

import '../models/movie_api.dart';

class HomePageDrawer extends StatefulWidget {
  const HomePageDrawer({Key? key}) : super(key: key);

  @override
  State<HomePageDrawer> createState() => _HomePageDrawerState();
}

class _HomePageDrawerState extends State<HomePageDrawer> {
  bool isSeries = true;
  MediaController mediaController = MediaController();

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      children: [
        SizedBox(
          height: 40,
        ),
        Container(
          padding:
              const EdgeInsets.only(top: 10, right: 5, left: 5, bottom: 10),
          child: TextFormField(
              style: const TextStyle(color: Color(0xffffffff)),
              cursorColor: const Color(0xffffffff),
              decoration: InputDecoration(
                  hintText: "إبحث في ماي سيما",
                  hintStyle: const TextStyle(color: Color(0xffffffff)),
                  prefixIcon: const Icon(Icons.search,
                      color: Color(0xffffffff), size: 40),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                  filled: true,
                  fillColor: const Color(0xff23273b))),
        ),
        SizedBox(
          height: 20,
        ),
        FutureBuilder(
          future: mediaController.apiHandler.getData(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null || snapshot.data.isEmpty) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: snapshot.data.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return GFAccordion(
                    textStyle: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                    collapsedTitleBackgroundColor: Color(0xff23273b),
                    contentBackgroundColor: Color(0xff23273b),
                    expandedTitleBackgroundColor: Color(0xff23273b),
                    title: "${snapshot.data[index]["name"]}",
                    contentChild: SizedBox(
                      width: double.infinity,
                      height: 200,
                      child: ListView.builder(
                          itemCount: snapshot.data[index]["children"].length,
                          itemBuilder: ((context, index2) {
                            var name = snapshot.data[index]["children"][index2]
                                ["name"];
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  mediaController.categoryDataHandler =
                                      FilteredData(
                                          termID: snapshot.data[index]
                                              ["children"][index2]["id"]);
                                  (index == 0)
                                      ? isSeries = false
                                      : isSeries = true;
                                  Navigator.pop(context);
                                });
                              },
                              child: ListTile(
                                title: Text(
                                  "$name",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            );
                          })),
                    ),
                  );
                },
              );
            }
          },
        ),
      ],
    ));
  }
}
