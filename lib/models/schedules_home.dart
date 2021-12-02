import 'package:app_sagem/models/employees.dart';
import 'package:app_sagem/models/services_home.dart';
import 'package:intl/intl.dart';

class ScheduleHome {
  final String id;
  final String dataSchedule;
  final String time;
  final bool cancel;
  final num price;
  Map<String, dynamic> employees;
  Map<String, dynamic> services;

  ScheduleHome(
    this.id,
    this.dataSchedule,
    this.time,
    this.price,
    this.cancel,
    this.employees,
    this.services,
  );

  ScheduleHome.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        dataSchedule = json['dataSchedule'],
        time = json['time'],
        price = json['price'],
        cancel = json['cancel'],
        employees = json[
            'employees'], //List<Employees>.from(json['employees'].map((x) => Employees.fromJson(x))),
        services = json[
            'services']; //List<ServicesHome>.from(json['services'].map((x) => ServicesHome.fromJson(x)));

  Map<String, dynamic> toJson() => {
        'id': id,
        'dataSchedule': dataSchedule,
        'time': time,
        'price': price,
        'cancel': cancel,
        'employees':
            employees, //List<dynamic>.from(employees.map((x) => x.toJson())),
        'services':
            services //List<dynamic>.from(services.map((x) => x.toJson()))
      };

  @override
  String toString() {
    return 'ScheduleHome{id: $id, dataSchedule: $dataSchedule, time: $time, price: $price}';
  }

  String getCurrency() {
    NumberFormat formatter = NumberFormat.simpleCurrency();
    return formatter.format(price);
  }
}
