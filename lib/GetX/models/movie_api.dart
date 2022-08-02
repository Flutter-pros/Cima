import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiHandler {
  ApiHandler(this.url);
  final String url;
  Future<List<dynamic>> getData() async {
    var result = await http.get(Uri.parse(url));
    return json.decode(result.body);
  }
}

class CategoryData extends ApiHandler {
  String taxonamy;
  String termID;
  CategoryData({this.taxonamy = "category", this.termID = "31341"})
      : super(
            "https://mycima.buzz:2096/appweb/posts/archived_$taxonamy[$termID]/");
}
