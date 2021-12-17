import 'dart:convert';
import 'package:app_sagem/http/webclient.dart';
import 'package:app_sagem/models/notifications.dart';
import 'package:http/http.dart'; 
import 'package:shared_preferences/shared_preferences.dart';

class NotificationsWebClient {
  Future<List<Notifications>> getNotifications() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final Response response = await client.get(
        Uri.parse(baseUrl + '/notifications'),
        headers: {"Authorization": token}).timeout(Duration(seconds: 5));

    final List<dynamic> decodedJson = jsonDecode(response.body);

    return decodedJson
        .map<Notifications>((json) => Notifications.fromJson(json))
        .toList();
  }
}
