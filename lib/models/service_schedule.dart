class ServicesSchedule {
  final String date;
  final List times;

  ServicesSchedule(
    this.date,
    this.times,
  );

  ServicesSchedule.fromJson(Map<String, dynamic> json)
      : date = json['date'],
        times = json['times'];

  Map<String, dynamic> toJson() => {
        'date': date,
        'times': times,
      };

  @override
  String toString() {
    return 'ServicesSchedule{date: $date, times: $times}';
  }
}
