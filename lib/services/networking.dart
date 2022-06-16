import 'dart:convert';
import 'package:http/http.dart' as http;

class NetworkHelper {
  NetworkHelper({required this.url});
  String url;

  Future getData() async {
    http.Response response = await http.get(Uri.parse(url));
    return jsonDecode(response.body);
  }
}
