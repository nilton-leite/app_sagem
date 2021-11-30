import 'dart:convert';
import 'package:app_sagem/http/webclient.dart';
import 'package:app_sagem/models/service.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ServicesWebClient {
  Future<List<Service>> findAll() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final Response response = await client.get(Uri.parse(baseUrl + '/services'),
        headers: {"Authorization": token}).timeout(Duration(seconds: 5));

    final List<dynamic> decodedJson = jsonDecode(response.body);

    return decodedJson
        .map<Service>((dynamic json) => Service.fromJson(json))
        .toList();
  }
}

class HttpException implements Exception {
  final String message;

  HttpException(this.message);
}
