import 'package:app_sagem/http/webclients/schedules.dart';
import 'package:app_sagem/models/schedules.dart';
import 'package:app_sagem/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:app_sagem/components/progress.dart';

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
      backgroundColor: Color(0xFFF6F3EE),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
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
                  style: GoogleFonts.dancingScript(
                    textStyle: TextStyle(
                      color: Color(0xFFCC39191),
                      letterSpacing: .5,
                      fontSize: 40,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              employeeService[0].service,
              style: GoogleFonts.dancingScript(
                textStyle: TextStyle(
                  color: Color(0xFFCC39191),
                  letterSpacing: .5,
                  fontSize: 30,
                ),
              ),
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
                  setState(() {
                    isLoading = true;
                  });

                  final teste = await _webclient.save(employeeId, serviceId,
                      dateChoice, scheduleChoice, employeeService[0].price);
                  setState(() {
                    if (teste) {
                      isLoading = false;
                    }
                  });

                  if (!isLoading) {
                    final snackBar = SnackBar(
                      content:
                          Text('Parabéns! Agendamento realizado com sucesso!'),
                      backgroundColor: Color(0xFFCC39191),
                    );

                    ScaffoldMessenger.of(context).showSnackBar(snackBar);

                    final navigator = Navigator.of(context);

                    navigator.popUntil((route) => route.isFirst);
                    navigator.pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => Dashboard(),
                      ),
                      (route) => false,
                    );
                  }
                },
                child: Text("Finalizar agendamento"),
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFFCC39191),
                  elevation: 1, //elevation of button
                  shape: RoundedRectangleBorder(
                    //to set border radius to button
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.all(15),
                ),
              ),
      ),
    );
  }
}
