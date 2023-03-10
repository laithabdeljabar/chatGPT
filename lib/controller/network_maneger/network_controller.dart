import 'dart:convert';
import 'package:chatgpt/controller/network_maneger/url_components.dart';
import 'package:http/http.dart' as http;

import 'expeption.dart';

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
    if (response.statusCode == 200) {
      return response.body;
    }
    if (response.statusCode == 400) {
      throw CustomExeption(errorDescreption: "Bad Request", statusCode: response.statusCode);
    }
    if (response.statusCode == 401 || response.statusCode == 403) {
      throw CustomExeption(errorDescreption: "Please Login Again", statusCode: response.statusCode);
    }
    if (response.statusCode == 404) {
      throw CustomExeption(errorDescreption: "Not Found!", statusCode: response.statusCode);
    }
    return "";
  }
}
