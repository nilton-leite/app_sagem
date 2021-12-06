import 'dart:convert';
import 'package:app_sagem/http/webclient.dart';
import 'package:app_sagem/models/user.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserWebClient {
  Future<List<UserBless>> get() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final Response response = await client.get(Uri.parse(baseUrl + '/user'),
        headers: {"Authorization": token}).timeout(Duration(seconds: 15));

    if (response.statusCode == 200) {
      final List<dynamic> decodedJson = jsonDecode(response.body);

      return decodedJson
          .map<UserBless>((dynamic json) => UserBless.fromJson(json))
          .toList();
    }

    throw HttpException(_getMessage(response.statusCode));
  }

  String _getMessage(int statusCode) {
    if (_statusCodeResponses.containsKey(statusCode)) {
      return _statusCodeResponses[statusCode];
    }
    return 'Erro desconhecido...';
  }

  static final Map<int, String> _statusCodeResponses = {
    401: 'Falha na autenticação!',
    502: 'Ocorreu um erro ao buscar os serviços'
  };
}

class HttpException implements Exception {
  final String message;

  HttpException(this.message);
}
