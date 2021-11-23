import 'package:app_sagem/models/service_schedule.dart';

class Schedule {
  final String fullName;
  final String telephone;
  final int price;
  final int executionTime;
  List<ServicesSchedule> intervalFinal;

  Schedule(
    this.fullName,
    this.telephone,
    this.price,
    this.executionTime,
    this.intervalFinal,
  );

  Schedule.fromJson(Map<String, dynamic> json)
      : fullName = json['fullName'],
        telephone = json['telephone'],
        price = json['price'],
        executionTime = json['executionTime'],
        intervalFinal = List<ServicesSchedule>.from(
            json['intervalFinal'].map((x) => ServicesSchedule.fromJson(x)));

  Map<String, dynamic> toJson() => {
        'fullName': fullName,
        'telephone': telephone,
        'price': price,
        'executionTime': executionTime,
        'intervalFinal':
            List<dynamic>.from(intervalFinal.map((x) => x.toJson()))
      };

  @override
  String toString() {
    return 'Services{date: $fullName, times: $telephone}';
  }
}
