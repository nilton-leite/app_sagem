import 'package:app_sagem/components/list_item.dart';
import 'package:app_sagem/models/service.dart';
import 'package:flutter/material.dart';

final items = List<ListItem>.generate(
  1000,
  (i) => i % 6 == 0
      ? HeadingItem('Heading $i')
      : MessageItem('Sender $i', 'Message body $i'),
);

class DetailsServices extends StatelessWidget {
  final Service service;
  const DetailsServices({Key key, this.service}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          service.title,
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
      ),
      body: ListView.builder(
        itemCount: service.employees.length,
        itemBuilder: (context, index) {
          final item = service.employees[index];

          return ListTile(
            title: Text(item.fullName),
            subtitle: Text(item.email),
          );
        },
      ),
    );
  }
}
