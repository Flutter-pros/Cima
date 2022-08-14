import 'package:cima/app/data/movie_api.dart';
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
  RxList categories = [].obs;
  RxList subCategories = [].obs;

  void updateDrawerData() {
    RxList drawerData = [].obs;

    drawerData = DrawerData().getData() as RxList;
    List<DrawerControllerData> drawerMenues = [];
    for (var mainCategory in drawerData) {
      drawerMenues.add(DrawerControllerData(
          categoryID: mainCategory['id'],
          categoryTitle: mainCategory['title'],
          type: mainCategory['type']));

      List children = mainCategory['children'];
      List<DrawerControllerData> categoryChildren = [];
      for (var subCategory in children) {
        categoryChildren.add(DrawerControllerData(
            categoryID: subCategory['id'],
            categoryTitle: subCategory['title'],
            type: subCategory['type']));
      }
      subCategories.add(categoryChildren as RxList);
    }
    categories.add(drawerMenues as RxList);
  }
}
