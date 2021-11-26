import 'package:app_sagem/http/webclients/schedules.dart';
import 'package:app_sagem/main.dart';
import 'package:app_sagem/models/schedules.dart';
import 'package:app_sagem/screens/dashboard.dart';
import 'package:app_sagem/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:app_sagem/components/progress.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class Revision extends StatefulWidget {
  final String dateChoice;
  final String scheduleChoice;
  final String employeeId;
  final String serviceId;
  final List<Schedule> employeeService;
  Revision(this.dateChoice, this.scheduleChoice, this.employeeService,
      this.employeeId, this.serviceId);

  @override
  RevisionState createState() => RevisionState(
      dateChoice, scheduleChoice, employeeService, employeeId, serviceId);
}

class RevisionState extends State<Revision> {
  final String dateChoice;
  final String scheduleChoice;
  final List<Schedule> employeeService;
  final String employeeId;
  final String serviceId;
  NumberFormat formatter = NumberFormat.simpleCurrency();
  final SchedulesWebClient _webclient = SchedulesWebClient();
  bool isLoading = false;

  RevisionState(this.dateChoice, this.scheduleChoice, this.employeeService,
      this.employeeId, this.serviceId);

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
        child: isLoading
            ? Progress()
            : ElevatedButton(
                onPressed: () async {
                  print('ANtes do pro');
                  setState(() {
                    isLoading = true;
                  });

                  // return CircularProgressIndicator();
                  final teste = await _webclient.save(
                      employeeId, serviceId, dateChoice, scheduleChoice);
                  setState(() {
                    if (teste) {
                      isLoading = false;
                    }
                  });

                  if (!isLoading) {
                    final snackBar = SnackBar(
                        content:
                            Text('Parabéns! Agendamento feito com sucesso!'));

                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
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

  Widget _showMessage(BuildContext context) {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute<void>(
    //     builder: (BuildContext context) => Dashboard(),
    //     fullscreenDialog: true,
    //   ),
    // );
  }
}
