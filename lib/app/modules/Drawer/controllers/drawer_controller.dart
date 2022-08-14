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

  void updateDrawerData() async {
    List drawerData = [];

    await DrawerData().getData().then((value) => drawerData.addAll(value));
    print("drawerData: $drawerData");
    List<DrawerControllerData> drawerMenues = [];
    for (var mainCategory in drawerData) {
      drawerMenues.add(DrawerControllerData(
          categoryID: mainCategory['id'],
          categoryTitle: mainCategory['name'],
          type: mainCategory['type']));

      List children = mainCategory['children'];
      List<DrawerControllerData> categoryChildren = [];
      for (var subCategory in children) {
        categoryChildren.add(DrawerControllerData(
            categoryID: subCategory['id'],
            categoryTitle: subCategory['name'],
            type: subCategory['type']));
      }
      subCategories.add(categoryChildren);
    }
    categories.addAll(drawerMenues);
  }
}
