import 'dart:convert';
import 'package:app_sagem/http/webclient.dart';
import 'package:app_sagem/models/service.dart';
import 'package:http/http.dart';

class ServicesWebClient {
  Future<List<Service>> findAll() async {
    final Response response = await client
        .get(Uri.parse(baseUrl + '/services'))
        .timeout(Duration(seconds: 5));

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
