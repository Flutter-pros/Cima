import 'package:http/http.dart' as http;
import 'dart:convert';
import '../library/globals.dart' as globals;

abstract class ApiHandler {
  String categoryID = globals.categoryID;

  late String url;

  ApiHandler(this.url);
  getData() async {
    url = (url.contains(".is/appweb/posts/category|"))
        ? "${globals.domain.substring(0, globals.domain.indexOf("."))}$url"
        : "${globals.domain}$url";
    var result = await http.get(Uri.parse(url));
    return json.decode(result.body);
  }
}

//! the below class is the only class which in all cases will return single object.
class MediaData extends ApiHandler {
  String mediaID;
  MediaData({this.mediaID = "31341"}) : super('/appweb/post/$mediaID/');
}

class DrawerData extends ApiHandler {
  DrawerData() : super("/appweb/menus");
}

class SearchData extends ApiHandler {
  String search;
  SearchData(this.search) : super("/appweb/search/$search/");
}

class RelatedPosts extends ApiHandler {
  String postID;
  RelatedPosts({this.postID = "31341"})
      : super("/appweb/posts/related/$postID/");
}

class CategorizedData extends ApiHandler {
  CategorizedData({required categoryID})
      : super("/appweb/posts/category|$categoryID/") {
    globals.categoryID = categoryID;
  }
}

class FilteredCategorizedData extends ApiHandler {
  String filterTaxonomy;
  String filterTermID;
  FilteredCategorizedData(
      {required this.filterTaxonomy, required this.filterTermID})
      : super(
            ".is/appweb/posts/category|${globals.categoryID}/$filterTaxonomy|$filterTermID/");
}

class SeriesEpisods extends ApiHandler {
  String seriesID;
  SeriesEpisods({required this.seriesID})
      : super("/appweb/posts/series|$seriesID/");
}

class Filters extends ApiHandler {
  Filters() : super("/appweb/filters/");
}
