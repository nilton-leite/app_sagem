import 'dart:convert';
import 'package:app_sagem/http/webclient.dart';
import 'package:app_sagem/models/schedules.dart';
import 'package:app_sagem/models/schedules_home.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SchedulesWebClient {
  Future<List<Schedule>> findSchedules(String serviceId, String employeeId,
      DateTime dateStart, DateTime dateEnd) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final Response response = await client.get(
        Uri.parse(baseUrl +
            '/schedules?serviceId=$serviceId&employeeId=$employeeId&start_date=$dateStart&end_date=$dateEnd'),
        headers: {"Authorization": token}).timeout(Duration(seconds: 5));

    final List<dynamic> decodedJson = jsonDecode(response.body);

    return decodedJson
        .map<Schedule>((json) => Schedule.fromJson(json))
        .toList();
  }

  Future<List<ScheduleHome>> findSchedulesHome(
      [String text, String serviceId]) async {
    if (text == null) text = '';
    if (serviceId == null) serviceId = '';

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final Response response = await client.get(
        Uri.parse(baseUrl +
            '/schedulesUser?text=$text&serviceId=$serviceId&cancel=false'),
        headers: {"Authorization": token}); //.timeout(Duration(seconds: 30));

    final List<dynamic> decodedJson = jsonDecode(response.body);

    return decodedJson
        .map<ScheduleHome>((json) => ScheduleHome.fromJson(json))
        .toList();
  }

  Future<List<ScheduleHome>> findMySchedules(
      [String text, String serviceId]) async {
    if (text == null) text = '';
    if (serviceId == null) serviceId = '';

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final Response response = await client.get(
        Uri.parse(baseUrl + '/schedulesUser?text=$text&serviceId=$serviceId'),
        headers: {"Authorization": token}).timeout(Duration(seconds: 30));

    final List<dynamic> decodedJson = jsonDecode(response.body);

    return decodedJson
        .map<ScheduleHome>((json) => ScheduleHome.fromJson(json))
        .toList();
  }

  Future<bool> save(String employeeId, String serviceId, String dataSchedule,
      String time, num price) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final String serviceJson = jsonEncode({
      "employeeId": employeeId,
      "serviceId": serviceId,
      "dataSchedule": dataSchedule,
      "time": time,
      "price": price
    });

    final Response response = await client
        .post(Uri.parse(baseUrl + '/schedules'),
            headers: {
              'Content-type': 'application/json',
              "Authorization": token
            },
            body: serviceJson)
        .timeout(Duration(seconds: 30));

    if (response.statusCode == 200) {
      return true;
    }

    throw HttpException(_getMessage(response.statusCode));
  }

  Future<Map<String, dynamic>> cancel(String scheduleId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final Response response = await client.get(
        Uri.parse(baseUrl + '/schedules/cancel?scheduleId=$scheduleId'),
        headers: {"Authorization": token}).timeout(Duration(seconds: 30));

    if (response.statusCode == 200 || response.statusCode == 400) {
      final Map<String, dynamic> decodedJson = jsonDecode(response.body);

      return decodedJson;
    }

    throw HttpException(_getMessage(response.statusCode));
  }

  Future<Map<String, dynamic>> confirm(String scheduleId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final Response response = await client.get(
        Uri.parse(baseUrl + '/schedules/confirm?scheduleId=$scheduleId'),
        headers: {"Authorization": token}).timeout(Duration(seconds: 30));

    if (response.statusCode == 200 || response.statusCode == 400) {
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
    502: 'Ocorreu um erro ao buscar os serviços',
    404: 'Serviço indisponivel no momento'
  };
}

class HttpException implements Exception {
  final String message;

  HttpException(this.message);
}
