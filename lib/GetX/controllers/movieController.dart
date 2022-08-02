import 'package:get/get.dart';

import '../models/movie_api.dart';

class MediaController extends GetxController {
  //* we will make the default state of the myhomepage to show the arabic series
  CategoryData categoryDataHandler = CategoryData();
  ApiHandler apiHandler = ApiHandler("https://mycima.tube/appweb/menus/");
  RxString mediaID = '31341'.obs;
  RxString mediaTitle = 'منورة باهلها'.obs;
  RxString mediaDescription =
      'مسلسلات اجنبى اون لاين , مشاهدة مسلسلات اجنبى خيال علمى اون لاين , مسلسلات اجنبى للكبار فقط , مسلسلات اجنبى للكبار فقط مترجمة , مسلسلات اجنبى اكشن , مسلسلات اجنبى 2022 '
          .obs;
  RxString mediaImage =
      'https://mycima.fun:2083:2096/wp-content/uploads/2021/06/_320x_e35c1fcb02a328da2bd5177ec3ec472dd5e3cd27b9d6ade259c55b3ef5389b1a1318070009.jpg'
          .obs;
  RxString mediaYear = '2022'.obs;
  RxString mediaRating = "3".obs;
  RxString mediaDurationInMinutes = "120".obs;
  RxList<String> mediaGenre = ["جريمة", "غموض"].obs;
  void updatemedia(
    RxString id,
    RxString title,
    RxString description,
    RxString image,
    RxString year,
    RxString rating,
    RxString duration,
    RxList<String> genre,
  ) {
    mediaID = id;
    mediaTitle = title;
    mediaDescription = description;
    mediaImage = image;
    mediaYear = year;
    mediaRating = rating;
    mediaDurationInMinutes = duration;
    mediaGenre = genre;
  }
}
