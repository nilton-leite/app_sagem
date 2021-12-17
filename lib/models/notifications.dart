import 'package:app_sagem/models/messages_notification.dart';

class Notifications {
  final int count;
  final String dateInsert;
  List<MessagesNotification> messages;

  Notifications(
    this.count,
    this.dateInsert,
    this.messages,
  );

  Notifications.fromJson(Map<String, dynamic> json)
      : count = json['count'],
        dateInsert = json['dateInsert'],
        messages = List<MessagesNotification>.from(
            json['messages'].map((x) => MessagesNotification.fromJson(x)));

  Map<String, dynamic> toJson() => {
        'count': count,
        'dateInsert': dateInsert,
        'messages': List<dynamic>.from(messages.map((x) => x.toJson())),
      };

  @override
  String toString() {
    return 'Notifications{count: $count, dateInsert: $dateInsert, messages: $messages}';
  }
}
