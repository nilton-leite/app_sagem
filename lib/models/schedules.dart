import 'package:app_sagem/models/service_schedule.dart';
import 'package:intl/intl.dart';

class Schedule {
  final String fullName;
  final String telephone;
  final String icon;
  final String service;
  final int price;
  final int executionTime;
  List<ServicesSchedule> intervalFinal;

  Schedule(
    this.fullName,
    this.telephone,
    this.icon,
    this.service,
    this.price,
    this.executionTime,
    this.intervalFinal,
  );

  Schedule.fromJson(Map<String, dynamic> json)
      : fullName = json['fullName'],
        telephone = json['telephone'],
        icon = json['icon'],
        service = json['service'],
        price = json['price'],
        executionTime = json['executionTime'],
        intervalFinal = List<ServicesSchedule>.from(
            json['intervalFinal'].map((x) => ServicesSchedule.fromJson(x)));

  Map<String, dynamic> toJson() => {
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
    return 'Services{date: $fullName, times: $telephone}';
  }

  String getCurrency() {
    NumberFormat formatter = NumberFormat.simpleCurrency();
    return formatter.format(price);
  }
}
