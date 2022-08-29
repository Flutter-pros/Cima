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
  List<String> filtersNames = [];
  List<List<Map<String, dynamic>>> filtersTerms = [];
  final MediaController mediaController = Get.put(MediaController());

  //!names of each filter
  @override
  void initState() {
    super.initState();
    getFiltersData();
  }

  void getFiltersData() async {
    await Filters().getData().then((value) {
      value.forEach((element) {
        filtersNames.add(element["taxonomy"]);
        filtersTerms.add(element["terms"]);
      });
    });

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // tag.forEach((element) {
    //   detailedFilters.add(filtersNames[element]);
    // });
    return SingleChildScrollView(
      child: Obx(
        () => Row(
          children: [
            ...filtersNames
                .map((e) => (e != "interest" && e != "category")
                    ? SingleFilter(
                        filterName: filtersNames[filtersNames.indexOf(e)],
                        filterTerms: (e != "mpaa")
                            ? filtersTerms[filtersNames.indexOf(e)]
                            : filtersTerms[filtersNames.indexOf(e)]
                                .where((element) =>
                                    element["slug"] == "tv-y" ||
                                    element["slug"] == "tv-g" ||
                                    element["slug"] == "g")
                                .toList(),
                        filterSelectedTerms: (filtersNames.indexOf(e) == 0)
                            ? [0]
                            : mediaController.filterTags)
                    : Container())
                .toList()
          ],
        ),
      ),
    );
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
  final List<Map<String, dynamic>> filterTerms;
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
        maxWidth: 150,
      ),
      child: Container(
        alignment: Alignment.topLeft,
        child: ExpansionTile(
          //! below is applied when the tile is expanded
          iconColor: Colors.white,
          textColor: Colors.white,
          backgroundColor: Colors.black.withOpacity(0.8),
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
            ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 300),
              child: SingleChildScrollView(
                child: ChipsChoice<int>.multiple(
                  direction: Axis.vertical,
                  choiceStyle: const C2ChoiceStyle(
                    color: Colors.black,
                  ),
                  value: widget.filterSelectedTerms,
                  onChanged: (val) {
                    setState(() {
                      tag = val;
                      for (var element in tag) {
                        mediaController.filterData(
                            taxonomy: widget.filterName,
                            termID: widget.filterTerms[element]["term_id"]);
                      }
                    });
                  },
                  choiceItems: C2Choice.listFrom<int, String>(
                    source: widget.filterTerms
                        .map((e) => e["slug"].toString().tr)
                        .toList(),
                    value: (i, v) => i,
                    label: (i, v) => v,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
