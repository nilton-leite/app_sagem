import 'dart:convert';
import 'package:app_sagem/http/webclient.dart';
import 'package:app_sagem/models/schedules.dart';
import 'package:http/http.dart';

class SchedulesWebClient {
  Future<List<Schedule>> findSchedules(String serviceId, String employeeId,
      DateTime dateStart, DateTime dateEnd) async {
    final Response response = await client
        .get(Uri.parse(baseUrl +
            '/schedules?serviceId=$serviceId&employeeId=$employeeId&start_date=$dateStart&end_date=$dateEnd'))
        .timeout(Duration(seconds: 5));

    final List<dynamic> decodedJson = jsonDecode(response.body);

    return decodedJson
        .map<Schedule>((json) => Schedule.fromJson(json))
        .toList();
  }

  Future<bool> save(String employeeId, String serviceId, String dataSchedule,
      String time) async {
    final String serviceJson = jsonEncode({
      "employeeId": employeeId,
      "serviceId": serviceId,
      "dataSchedule": dataSchedule,
      "time": time,
      "userId": "6116bf9e1c964e29788db56a"
    });

    final Response response = await client
        .post(Uri.parse(baseUrl + '/schedules'),
            headers: {'Content-type': 'application/json'}, body: serviceJson)
        .timeout(Duration(seconds: 15));

    if (response.statusCode == 200) {
      return true;
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
