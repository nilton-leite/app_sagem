import 'package:app_sagem/models/employees.dart';

class Service {
  final String id;
  final String title;
  final String description;
  final String price;
  final String startTime;
  final String endTime;
  final String intervalTime;
  final String icon;
  List<Employees> employees;

  Service(
    this.id,
    this.title,
    this.description,
    this.price,
    this.startTime,
    this.endTime,
    this.intervalTime,
    this.icon,
    this.employees,
  );

  Service.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        title = json['title'],
        description = json['description'],
        price = json['price'],
        startTime = json['startTime'],
        endTime = json['endTime'],
        intervalTime = json['intervalTime'],
        icon = json['icon'],
        employees = List<Employees>.from(
            json['employees'].map((x) => Employees.fromJson(x)));

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'price': price,
        'startTime': startTime,
        'endTime': endTime,
        'intervalTime': intervalTime,
        'icon': icon,
        'employees': List<dynamic>.from(
            employees.map((x) => x.toJson())), //employees.toJson(),
      };

  @override
  String toString() {
    return 'Services{title: $title, description: $description, price: $price, startTime: $startTime, endTime: $endTime, intervalTime: $intervalTime, icon: $icon, employees: $employees}';
  }
}
