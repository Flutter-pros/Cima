import 'package:cima/app/modules/HomePageBody/controllers/media_controller.dart';
import 'package:flutter/material.dart';
import 'package:chips_choice_null_safety/chips_choice_null_safety.dart';
import 'package:cima/app/data/movie_api.dart';
import 'package:get/get.dart';

class HomePageFilters extends StatefulWidget {
  const HomePageFilters({Key? key}) : super(key: key);

  @override
  State<HomePageFilters> createState() => _HomePageFiltersState();
}

class _HomePageFiltersState extends State<HomePageFilters> {
  //!taxonomy

  final MediaController mediaController = Get.put(MediaController());

  //!names of each filter
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Filters().getData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  String filterName = snapshot.data[index]["taxonomy"];
                  List filterTerms = snapshot.data[index]["terms"];
                  return (filterName != "category" && filterName != "interest")
                      ? SingleFilter(
                          filterName: snapshot.data[index]["taxonomy"],
                          filterTerms: (filterName == "mpaa")
                              ? filterTerms.where((term) {
                                  return term["slug"] == "tv-y" ||
                                      term["slug"] == "tv-g" ||
                                      term["slug"] == "g";
                                }).toList()
                              : filterTerms,
                          filterSelectedTerms: const [])
                      : Container();
                });
          } else {
            return Container();
          }
        });
  }
}

class SingleFilter extends StatefulWidget {
  const SingleFilter(
      {Key? key,
      required this.filterName,
      required this.filterTerms,
      required this.filterSelectedTerms})
      : super(key: key);
  final String filterName;
  final List filterTerms;
  final List<int> filterSelectedTerms;

  @override
  State<SingleFilter> createState() => _SingleFilterState();
}

class _SingleFilterState extends State<SingleFilter> {
  List<int> tag = [];
  final MediaController mediaController = Get.put(MediaController());

  @override
  void initState() {
    super.initState();
    tag = widget.filterSelectedTerms;
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: 200,
      ),
      child: Container(
        alignment: Alignment.topLeft,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: ExpansionTile(
            onExpansionChanged: (value) {
              if (value) {
                mediaController.isAnyFilterExpanded.value = true;
              } else {
                mediaController.isAnyFilterExpanded.value = false;
              }
            },
            //! below is applied when the tile is expanded
            iconColor: Colors.white,
            textColor: Colors.white,
            backgroundColor: Colors.black.withOpacity(0.2),
            //! below is applied when the tile is collapsed
            collapsedIconColor: Colors.white,
            collapsedTextColor: Colors.white,
            title: Row(
              children: [
                const Icon(Icons.filter_list),
                const SizedBox(width: 5),
                Text(
                  widget.filterName.tr,
                ),
              ],
            ),
            children: [
              OrientationBuilder(
                builder: (context, orientation) {
                  return SizedBox(
                    height: (orientation == Orientation.portrait) ? 300 : 50,
                    child: SingleChildScrollView(
                      child: ChipsChoice<int>.multiple(
                        direction: Axis.vertical,
                        choiceStyle: const C2ChoiceStyle(
                          color: Colors.black,
                        ),
                        value: tag,
                        onChanged: (val) {
                          setState(() {
                            tag = val;
                            for (var element in tag) {
                              mediaController.filterCategorizedData(
                                  filtereName: widget.filterName,
                                  filterTermId:
                                      "${widget.filterTerms[element]["term_id"]}");
                            }
                          });
                        },
                        choiceItems: C2Choice.listFrom<int, String>(
                          source: (widget.filterName == "mpaa")
                              ? widget.filterTerms
                                  .map((e) => e["slug"].toString().tr)
                                  .toList()
                              : widget.filterTerms
                                  .map((e) => e["name"].toString().tr)
                                  .toList(),
                          value: (i, v) => i,
                          label: (i, v) => v,
                        ),
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
