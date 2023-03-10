import 'dart:convert';
import 'package:chatgpt/controller/network_maneger/url_components.dart';
import 'package:http/http.dart' as http;

class NetworkController {
  Future<String?> restApi(
    String baseUrl,
    String endPoints,
    HttpMethod method, {
    Map<String, String>? header,
    Map<String, Object>? body,
  }) async {
    var url = Uri.parse("$baseUrl/$endPoints");
    http.Response? response;

    switch (method) {
      case HttpMethod.GET:
        response = await http.get(url, headers: header);
        break;
      case HttpMethod.POST:
        response = await http.post(url, headers: header, body: jsonEncode(body));
        break;
    }

    return response.body;
  }
}
