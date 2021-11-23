import 'package:app_sagem/models/employees.dart';

class Service {
  final String id;
  final String title;
  final String description;
  final int priceDefault;
  final int executionTimeDefault;
  final String icon;
  List<Employees> employees;

  Service(
    this.id,
    this.title,
    this.description,
    this.priceDefault,
    this.executionTimeDefault,
    this.icon,
    this.employees,
  );

  Service.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        title = json['title'],
        description = json['description'],
        priceDefault = json['price_default'],
        executionTimeDefault = json['execution_time_default'],
        icon = json['icon'],
        employees = List<Employees>.from(
            json['employees'].map((x) => Employees.fromJson(x)));

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'price': priceDefault,
        'intervalTime': executionTimeDefault,
        'icon': icon,
        'employees': List<dynamic>.from(
            employees.map((x) => x.toJson())), //employees.toJson(),
      };

  @override
  String toString() {
    return 'Services{title: $title, description: $description, price: $priceDefault, executionTime: $executionTimeDefault, icon: $icon, employees: $employees}';
  }
}
