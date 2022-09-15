import 'package:http/http.dart' as http;
import 'dart:convert';
import '../library/globals.dart' as globals;

abstract class ApiHandler {
  String categoryID = globals.categoryID;
  final String domain = "https://mycima";
  late String url;
  ApiHandler();

  getData() async {
    url = "$domain$url";
    var result = await http.get(Uri.parse(url));
    return json.decode(result.body);
  }
}

//! the below class is the only class which in all cases will return single object.
class MediaData extends ApiHandler {
  String mediaID;
  MediaData({this.mediaID = "31341"}) : super() {
    url = '.buzz:2096/appweb/post/$mediaID/';
  }
}

class DrawerData extends ApiHandler {
  DrawerData() : super() {
    url = ".buzz:2096/appweb/menus";
  }
}

class SearchData extends ApiHandler {
  String search;
  SearchData(this.search) : super() {
    url = ".buzz:2096/appweb/search/$search/";
  }
}

class RelatedPosts extends ApiHandler {
  String postID;
  RelatedPosts({this.postID = "31341"}) : super() {
    url = ".buzz:2096/appweb/posts/related/$postID/";
  }
}

class CategorizedData extends ApiHandler {
  CategorizedData({required categoryID}) : super() {
    globals.categoryID = categoryID;
    url = ".buzz:2096/appweb/posts/archived_category[$categoryID]/";
  }
}

class FilteredCategorizedData extends ApiHandler {
  String filterTaxonomy;
  String filterTermID;
  FilteredCategorizedData(
      {required this.filterTaxonomy, required this.filterTermID})
      : super() {
    url =
        ".is/appweb/posts/category|${globals.categoryID}/$filterTaxonomy|$filterTermID/";
  }
}

class Filters extends ApiHandler {
  Filters() : super() {
    url = ".buzz:2096/appweb/filters/";
  }
}
