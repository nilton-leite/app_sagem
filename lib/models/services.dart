import 'package:flutter/cupertino.dart';

class Service {
  final String id;
  final String title;
  final String description;
  final String price;
  final String startTime;
  final String endTime;
  final String intervalTime;
  final String icon;

  Service(
    this.id,
    this.title,
    this.description,
    this.price,
    this.startTime,
    this.endTime,
    this.intervalTime,
    this.icon,
  );

  Service.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        title = json['title'],
        description = json['description'],
        price = json['price'],
        startTime = json['startTime'],
        endTime = json['endTime'],
        intervalTime = json['intervalTime'],
        icon = json['icon'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'price': price,
        'startTime': startTime,
        'endTime': endTime,
        'intervalTime': intervalTime,
        'icon': icon,
      };

  @override
  String toString() {
    return 'Services{title: $title, description: $description, price: $price, startTime: $startTime, endTime: $endTime, intervalTime: $intervalTime, icon: $icon}';
  }
}
