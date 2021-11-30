import 'dart:convert';
import 'package:app_sagem/http/webclient.dart';
import 'package:http/http.dart';

class LoginWebClient {
  Future<Map<String, dynamic>> validateUser(String email) async {
    final Response response = await client
        .get(Uri.parse(baseUrl + '/user/validate?email=$email'))
        .timeout(Duration(seconds: 5));

    final Map<String, dynamic> decodedJson = jsonDecode(response.body);

    return decodedJson;
  }

  Future<Map<String, dynamic>> login(String email, String tokenFirebase) async {
    final String serviceJson =
        jsonEncode({"email": email, "tokenFirebase": tokenFirebase});

    final Response response = await client
        .post(Uri.parse(baseUrl + '/login'),
            headers: {'Content-type': 'application/json'}, body: serviceJson)
        .timeout(Duration(seconds: 15));

    if (response.statusCode == 200) {
      final Map<String, dynamic> decodedJson = jsonDecode(response.body);

      return decodedJson;
    }

    throw HttpException(_getMessage(response.statusCode));
  }

  Future<Map<String, dynamic>> save(
      String fullName,
      String telephone,
      String email,
      String tokenFirebase,
      String tokenFacebook,
      String tokenGoogle) async {
    final String serviceJson = jsonEncode({
      "full_name": fullName,
      "telephone": telephone,
      "email": email,
      "tokenFirebase": tokenFirebase,
      "tokenFacebook": tokenFacebook,
      "tokenGoogle": tokenGoogle
    });

    final Response response = await client
        .post(Uri.parse(baseUrl + '/users'),
            headers: {'Content-type': 'application/json'}, body: serviceJson)
        .timeout(Duration(seconds: 15));

    if (response.statusCode == 200) {
      final Map<String, dynamic> decodedJson = jsonDecode(response.body);

      return decodedJson;
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
