import 'package:app_sagem/components/progress.dart';
import 'package:app_sagem/http/webclients/schedules.dart';
import 'package:app_sagem/models/schedules_home.dart';
import 'package:app_sagem/models/service.dart';
import 'package:app_sagem/screens/home/card.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  final SchedulesWebClient _webclient = SchedulesWebClient();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Bem vindo, Nilton',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: FutureBuilder<List>(
        initialData: [],
        future: _webclient?.findSchedulesHome(),
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
                final List<ScheduleHome> scheduleHome = snapshot.data;

                const TextStyle optionStyle = TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                );
                if (scheduleHome.isNotEmpty) {
                  return CardHome(
                      scheduleHome: scheduleHome, optionStyle: optionStyle);
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
