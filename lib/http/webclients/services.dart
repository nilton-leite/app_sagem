import 'dart:convert';
import 'package:app_sagem/http/webclient.dart';
import 'package:app_sagem/models/service.dart';
import 'package:http/http.dart';

class ServicesWebClient {
  Future<List<Service>> findAll() async {
    final Response response =
        await client.get(Uri.parse(baseUrl)).timeout(Duration(seconds: 5));

    final List<dynamic> decodedJson = jsonDecode(response.body);

    return decodedJson
        .map<Service>((dynamic json) => Service.fromJson(json))
        .toList();
  }

  Future<Service> save(Service service, String password) async {
    final String serviceJson = jsonEncode(service.toJson());

    final Response response = await client.post(Uri.parse(baseUrl),
        headers: {
          'Content-type': 'application/json',
          'password': password,
        },
        body: serviceJson);
    // .timeout(Duration(seconds: 15));

    if (response.statusCode == 200) {
      return Service.fromJson(jsonDecode(response.body));
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
