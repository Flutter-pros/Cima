import 'package:cima/data/movie_api.dart';
import 'package:get/get.dart';

class DrawerControllerData {
  late String categoryID;
  late String categoryTitle;
  late String type;
  DrawerControllerData(
      {required this.categoryID,
      required this.categoryTitle,
      required this.type});
}

class DrawerController extends GetxController {
  RxList drawerData = [].obs;
  RxList categories = [].obs;
  RxList subCategories = [].obs;

  void updateDrawerData() {
    drawerData = DrawerData().getData() as RxList;
    for (var value in drawerData.value) {
      for (var i = 0; i < value.length; i++) {
        categories.value.add(DrawerControllerData(
            categoryID: value[i]['id'],
            categoryTitle: value[i]['title'],
            type: value[i]['type']));

        List children = value[i]['children'];
        List<DrawerControllerData> categoryChildren = [];
        for (var element in children) {
          categoryChildren.add(DrawerControllerData(
              categoryID: element['id'],
              categoryTitle: element['title'],
              type: element['type']));
        }
        subCategories.value.addAll(categoryChildren);
      }
    }
  }
}
