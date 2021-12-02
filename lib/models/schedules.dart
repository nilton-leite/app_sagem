import 'package:app_sagem/models/service_schedule.dart';
import 'package:intl/intl.dart';

class Schedule {
  final String id;
  final String fullName;
  final String telephone;
  final String icon;
  final String service;
  final num price;
  final int executionTime;
  List<ServicesSchedule> intervalFinal;

  Schedule(
    this.id,
    this.fullName,
    this.telephone,
    this.icon,
    this.service,
    this.price,
    this.executionTime,
    this.intervalFinal,
  );

  Schedule.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        fullName = json['fullName'],
        telephone = json['telephone'],
        icon = json['icon'],
        service = json['service'],
        price = json['price'],
        executionTime = json['executionTime'],
        intervalFinal = List<ServicesSchedule>.from(
            json['intervalFinal'].map((x) => ServicesSchedule.fromJson(x)));

  Map<String, dynamic> toJson() => {
        'id': id,
        'fullName': fullName,
        'telephone': telephone,
        'icon': icon,
        'service': service,
        'price': price,
        'executionTime': executionTime,
        'intervalFinal':
            List<dynamic>.from(intervalFinal.map((x) => x.toJson()))
      };

  @override
  String toString() {
    return 'Schedules{date: $fullName, times: $telephone}';
  }

  String getCurrency() {
    NumberFormat formatter = NumberFormat.simpleCurrency();
    return formatter.format(price);
  }
}
