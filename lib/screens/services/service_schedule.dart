import 'package:app_sagem/components/progress.dart';
import 'package:app_sagem/components/title_bottom_sheet.dart';
import 'package:app_sagem/http/webclients/services.dart';
import 'package:app_sagem/models/service.dart';
import 'package:app_sagem/models/service_schedule.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class ServiceSchedule extends StatefulWidget {
  final String employeeId;
  final String serviceId;
  ServiceSchedule(this.employeeId, this.serviceId);

  @override
  ServiceScheduleState createState() =>
      ServiceScheduleState(employeeId, serviceId);
}

class ServiceScheduleState extends State<ServiceSchedule> {
  final String employeeId;
  final String serviceId;
  DateRangePickerController _datePickerController = DateRangePickerController();
  final ServicesWebClient _webclient = ServicesWebClient();

  ServiceScheduleState(this.employeeId, this.serviceId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Agendamentos',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              SfDateRangePicker(
                onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
                  _onSelectedData(args, context, employeeId, serviceId);
                },
                selectionMode: DateRangePickerSelectionMode.range,
                startRangeSelectionColor: Colors.amber[800],
                endRangeSelectionColor: Colors.amber[800],
                rangeSelectionColor: Colors.amber,
                rangeTextStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
                minDate: DateTime.now(),
                controller: _datePickerController,
              ),
            ],
          )
        ],
      ),
    );
  }

  void _onSelectedData(DateRangePickerSelectionChangedArgs args,
      BuildContext context, String employeeId, String serviceId) {
    final TextStyle styleTitle = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.bold,
      color: Colors.amber[800],
    );

    if (args.value.startDate != null && args.value.endDate != null) {
      final DateTime dataDias =
          args.value.startDate.add(const Duration(days: 15));
      var difference = args.value.endDate.difference(args.value.startDate);

      if (difference.inDays <= 15) {
        _showModalSechedules(context, styleTitle, args.value.startDate,
            args.value.endDate, employeeId, serviceId);
      } else {
        final snackBar = SnackBar(
          content: const Text(
              'As datas precisam estar entre 15 dias. Aplicar automaticamente?'),
          action: SnackBarAction(
            label: 'Aplicar',
            onPressed: () {
              _datePickerController.selectedRange =
                  PickerDateRange(args.value.startDate, dataDias);
            },
          ),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }

  void _showModalSechedules(
      BuildContext context,
      TextStyle styleTitle,
      DateTime dateStart,
      DateTime dateEnd,
      String employeeId,
      String serviceId) {
    showModalBottomSheet(
      context: context,
      elevation: 5,
      useRootNavigator: true,
      isScrollControlled: true,
      isDismissible: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20.0),
        ),
      ),
      builder: (BuildContext contextBottomSheet) {
        return FutureBuilder<List>(
          initialData: [],
          future: _webclient?.findSchedules(
              serviceId, employeeId, dateStart, dateEnd),
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
                  final List<ServicesSchedule> schedules = snapshot.data;
                  if (schedules.isNotEmpty) {
                    return StatefulBuilder(
                      builder: (
                        BuildContext contextBuilder,
                        StateSetter setState,
                      ) {
                        return Padding(
                          padding: EdgeInsets.only(
                              bottom: MediaQuery.of(contextBottomSheet)
                                  .viewInsets
                                  .bottom),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.90,
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                TitleBottomSheet(
                                    title:
                                        "Escolha o horário para seu agendamento: ",
                                    style: styleTitle),
                                _expandedListDate(context, schedules, setState),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                }
                return Text('Elaia');
            }
            return Text('Elaia 2');
          },
        );
      },
    );
  }

  String groupValueRadioList;

  Expanded _expandedListDate(
    BuildContext context,
    List<ServicesSchedule> schedules,
    StateSetter setState,
  ) {
    return Expanded(
      child: Container(
        height: MediaQuery.of(context).size.height,
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: schedules.length,
          itemBuilder: (contextList, index) {
            return ExpansionTile(
              title: Text(
                schedules[index].date,
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              children: <Widget>[
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: schedules[index].times.length,
                  itemBuilder: (context, index1) {
                    groupValueRadioList = null;
                    return Theme(
                      data: ThemeData(
                        unselectedWidgetColor: Colors.amber[800],
                      ),
                      child: RadioListTile<String>(
                        title: Text(schedules[index].times[index1]),
                        value: schedules[index].times[index1],
                        groupValue: groupValueRadioList,
                        onChanged: (String choice) {
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Agendamento'),
                                content: Text('Deseja agendar para o dia ' +
                                    schedules[index].date +
                                    ' ás ' +
                                    schedules[index].times[index1]),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, 'Cancelar'),
                                    child: const Text('Cancelar'),
                                  ),
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, 'SIM'),
                                    child: const Text('SIM'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        // ignore: unrelated_type_equality_checks
                        selected: groupValueRadioList == index,
                        toggleable: true,
                        // subtitle: Text(
                        //     service.employees[index].description ?? 'A seu dispor'),
                        secondary: Icon(Icons.access_time),
                        controlAffinity: ListTileControlAffinity.trailing,
                        activeColor: Colors.amber[800],
                      ),
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
