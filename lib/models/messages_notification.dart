class MessagesNotification {
  final String title;
  final String body;
  final String date;

  MessagesNotification(
    this.title,
    this.body,
    this.date,
  );

  MessagesNotification.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        body = json['body'],
        date = json['date'];

  Map<String, dynamic> toJson() => {
        'title': title,
        'body': body,
        'date': date,
      };

  @override
  String toString() {
    return 'MessagesNotification{title: $title, body: $body, date: $date}';
  }
}
