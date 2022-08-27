import 'package:flutter/material.dart';
import 'package:cima/app/modules/HomePageBody/controllers/media_controller.dart';
import 'package:chips_choice_null_safety/chips_choice_null_safety.dart';
import 'package:cima/app/data/movie_api.dart';

class HomePageFilters extends StatefulWidget {
  const HomePageFilters({Key? key}) : super(key: key);

  @override
  State<HomePageFilters> createState() => _HomePageFiltersState();
}

class _HomePageFiltersState extends State<HomePageFilters> {
  List<int> tag = [0];
  //!taxonomy
  List<String> filtersNames = [];
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
      });
    });
    setState(() {});
  }

  List detailedFilters = [];
  @override
  Widget build(BuildContext context) {
    // tag.forEach((element) {
    //   detailedFilters.add(filtersNames[element]);
    // });
    return ExpansionTile(
      //! below is applied when the tile is expanded
      iconColor: Colors.white,
      textColor: Colors.white,
      backgroundColor: Colors.black.withOpacity(0.8),
      //! below is applied when the tile is collapsed
      collapsedIconColor: Colors.white,
      collapsedTextColor: Colors.white,
      title: Row(
        children: const [
          Icon(Icons.filter_list),
          SizedBox(width: 5),
          Text(
            'فلاتر',
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
              value: tag,
              onChanged: (val) => setState(() => tag = val),
              choiceItems: C2Choice.listFrom<int, String>(
                source: filtersNames,
                value: (i, v) => i,
                label: (i, v) => v,
              ),
            ),
          ),
        ),
        ...detailedFilters
      ],
    );
  }
}
