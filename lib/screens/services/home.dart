import 'package:app_sagem/components/progress.dart';
import 'package:app_sagem/http/webclients/services.dart';
import 'package:app_sagem/models/service.dart';
import 'package:app_sagem/screens/services/card.dart';
import 'package:flutter/material.dart';

class Services extends StatelessWidget {
  final ServicesWebClient _webclient = ServicesWebClient();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Serviços',
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
      ),
      backgroundColor: Colors.blueGrey[50],
      body: FutureBuilder<List>(
        initialData: [],
        future: _webclient?.findAll(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return Progress();
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              if (snapshot.hasData) {
                final List<Service> services = snapshot.data;

                const TextStyle optionStyle = TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                );
                if (services.isNotEmpty) {
                  return CardService(
                      services: services, optionStyle: optionStyle);
                }
              }
              return Text('Elaia');
          }
          return Text('Elaia 2');
        },
      ),
    );
  }
}
