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
