import 'package:cima/GetX/models/movie_api.dart';
import 'package:get/get.dart';

class DrawerController extends GetxController {
  List<DrawerController> categories = [];
  List<DrawerController> subCategories = [];
  late String categoryID;
  late String categoryTitle;
  late String type;
  DrawerController(
      {required this.categoryID,
      required this.categoryTitle,
      required this.type});
  var drawerData;
  DrawerController.getDrawerData() {
    drawerData = DrawerData().getData();
    drawerData.then((value) {
      for (var i = 0; i < value.length; i++) {
        categoryID = value[i]['id'];
        categoryTitle = value[i]['title'];
        type = value[i]['type'];

        categories.add(DrawerController(
            categoryID: categoryID, categoryTitle: categoryTitle, type: type));

        List children = value[i]['children'];
        children.forEach((element) {
          subCategories.add(DrawerController(
              categoryID: element['id'],
              categoryTitle: element['title'],
              type: element['type']));
        });
      }
    });
    update();
  }
}
