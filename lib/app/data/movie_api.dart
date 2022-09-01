import 'package:http/http.dart' as http;
import 'dart:convert';

abstract class ApiHandler {
  ApiHandler(this.url);
  final String url;
  getData() async {
    var result = await http.get(Uri.parse(url));
    return json.decode(result.body);
  }
}

//! the below class is the only class which in all cases will return single object.
class MediaData extends ApiHandler {
  String mediaID;
  MediaData({this.mediaID = "31341"})
      : super('https://mycima.buzz:2096/appweb/post/$mediaID/');
}

class DrawerData extends ApiHandler {
  DrawerData() : super("https://mycima.buzz:2096/appweb/menus");
}

class SearchData extends ApiHandler {
  String search;
  SearchData(this.search) : super("https://mycima.buzz/appweb/search/$search/");
}

class RelatedPosts extends ApiHandler {
  String postID;
  RelatedPosts({this.postID = "31341"})
      : super("https://mycima.buzz/appweb/posts/related/$postID/");
}

class FilteredData extends ApiHandler {
  String taxonamy;
  String termID;
  FilteredData({this.taxonamy = "category", this.termID = "12"})
      : super("https://mycima.buzz/appweb/posts/archived_$taxonamy[$termID]/");
}

class Filters extends ApiHandler {
  Filters() : super("https://mycima.buzz/appweb/filters/");
}
