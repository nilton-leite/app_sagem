import 'package:app_sagem/components/dynamic_icon.dart';
import 'package:app_sagem/models/schedules_home.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardHome extends StatefulWidget {
  final List<ScheduleHome> scheduleHome;
  final TextStyle optionStyle;
  const CardHome({
    Key key,
    this.scheduleHome,
    this.optionStyle,
  }) : super(key: key);

  @override
  _CardHomeState createState() =>
      _CardHomeState(this.optionStyle, this.scheduleHome);
}

class _CardHomeState extends State<CardHome> {
  final List<ScheduleHome> scheduleHome;
  final TextStyle optionStyle;
  _CardHomeState(this.optionStyle, this.scheduleHome);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 415,
          mainAxisExtent: 250,
          childAspectRatio: 1,
          crossAxisSpacing: 1,
          mainAxisSpacing: 1),
      itemBuilder: (contextGrid, index) {
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            child: InkWell(
              onTap: () {
                print('Teste');
              },
              child: Card(
                clipBehavior: Clip.antiAlias,
                child: Column(
                  children: [
                    ListTile(
                      leading: DynamicIcon(
                        scheduleHome[index].services[0].icon,
                        color: Colors.amber[800],
                        size: 30.0,
                      ),
                      title: Text(scheduleHome[index].services[0].title),
                      subtitle: Text(
                        scheduleHome[index].services[0].description,
                        style: TextStyle(color: Colors.black.withOpacity(0.6)),
                      ),
                    ),
                    ListTile(
                      // leading: Icon(Icons.arrow_drop_down_circle),
                      title: Text(scheduleHome[index].employees[0].fullName),
                      subtitle: Text(
                        UtilBrasilFields.obterCpf(
                                scheduleHome[index].employees[0].cpf) +
                            ' / ' +
                            UtilBrasilFields.obterTelefone(
                                scheduleHome[index].employees[0].telephone),
                        style: TextStyle(color: Colors.black.withOpacity(0.6)),
                      ),
                    ),
                    ListTile(
                      // leading: Icon(Icons.arrow_drop_down_circle),
                      title: Text(scheduleHome[index].dataSchedule),
                      subtitle: Text(
                        scheduleHome[index].time,
                        style: TextStyle(color: Colors.black.withOpacity(0.6)),
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.all(16.0),
                    //   child: Text(
                    //     'Greyhound divisively hello coldly wonderfully marginally far upon excluding.',
                    //     style: TextStyle(color: Colors.black.withOpacity(0.6)),
                    //   ),
                    // ),
                    // ButtonBar(
                    //   alignment: MainAxisAlignment.start,
                    //   children: [
                    //     ElevatedButton(
                    //       onPressed: () {
                    //         // Perform some action
                    //       },
                    //       child: const Text('ACTION 1'),
                    //     ),
                    //     ElevatedButton(
                    //       onPressed: () {
                    //         // Perform some action
                    //       },
                    //       child: const Text('ACTION 2'),
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      itemCount: scheduleHome.length,
    );
  }
}
