import 'package:get/get.dart';

class MediaController extends GetxController {
  //* we will make the default state of the myhomepage to show the arabic series
  static MediaController get to => Get.find();
  var mediaID = '31341'.obs;
  String mediaTitle = 'منورة باهلها';
  String mediaDescription =
      'مسلسلات اجنبى اون لاين , مشاهدة مسلسلات اجنبى خيال علمى اون لاين , مسلسلات اجنبى للكبار فقط , مسلسلات اجنبى للكبار فقط مترجمة , مسلسلات اجنبى اكشن , مسلسلات اجنبى 2022 ';
  String mediaImage =
      'https://mycima.fun:2083:2096/wp-content/uploads/2021/06/_320x_e35c1fcb02a328da2bd5177ec3ec472dd5e3cd27b9d6ade259c55b3ef5389b1a1318070009.jpg';
  String mediaYear = '2022';
  String mediaRating = "3";
  String mediaDurationInMinutes = "120";
  List<String> mediaGenre = ["جريمة", "غموض"];
  void updatemedia(
    var id,
    String title,
    String description,
    String image,
    String year,
    String rating,
    String duration,
    List<String> genre,
  ) {
    mediaID = id;
    mediaTitle = title;
    mediaDescription = description;
    mediaImage = image;
    mediaYear = year;
    mediaRating = rating;
    mediaDurationInMinutes = duration;
    mediaGenre = genre;
    update();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  // instead dispose() in StatefulWidget
  // work automatically when the controller be deleted from memory
  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
