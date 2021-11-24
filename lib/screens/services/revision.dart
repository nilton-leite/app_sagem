import 'package:app_sagem/models/schedules.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Revision extends StatefulWidget {
  final String dateChoice;
  final String scheduleChoice;
  final List<Schedule> employeeService;
  Revision(this.dateChoice, this.scheduleChoice, this.employeeService);

  @override
  RevisionState createState() =>
      RevisionState(dateChoice, scheduleChoice, employeeService);
}

class RevisionState extends State<Revision> {
  final String dateChoice;
  final String scheduleChoice;
  final List<Schedule> employeeService;
  NumberFormat formatter = NumberFormat.simpleCurrency();

  RevisionState(this.dateChoice, this.scheduleChoice, this.employeeService);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Revisão',
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  'Você está agendando',
                  style: TextStyle(fontSize: 30),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              employeeService[0].service,
              style: TextStyle(fontSize: 20),
            ),
          ),
          Divider(
            height: 20,
            thickness: 1,
            indent: 20,
            endIndent: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Atendente: "),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(employeeService[0].fullName),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Data: "),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(dateChoice),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Hora: "),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(scheduleChoice),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Valor Total: "),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(formatter.format(employeeService[0].price)),
              ),
            ],
          ),
          Divider(
            height: 20,
            thickness: 1,
            indent: 20,
            endIndent: 20,
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () {
            print('OIE AMIGOS');
          },
          child: Text("Finalizar agendamento"),
          style: ElevatedButton.styleFrom(
            primary: Colors.amber[800],
            elevation: 1, //elevation of button
            shape: RoundedRectangleBorder(
                //to set border radius to button
                borderRadius: BorderRadius.circular(10)),
            padding: EdgeInsets.all(15),
          ),
        ),
      ),
    );
  }
}
