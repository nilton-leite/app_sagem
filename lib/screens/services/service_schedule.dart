import 'package:app_sagem/components/empty.dart';
import 'package:app_sagem/components/progress.dart';
import 'package:app_sagem/components/title_bottom_sheet.dart';
import 'package:app_sagem/http/webclients/schedules.dart';
import 'package:app_sagem/models/schedules.dart';
import 'package:app_sagem/screens/services/revision.dart';
import 'package:empty_widget/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class ServiceSchedule extends StatefulWidget {
  final String employeeId;
  final String serviceId;
  ServiceSchedule(this.employeeId, this.serviceId);

  @override
  ServiceScheduleState createState() =>
      ServiceScheduleState(employeeId, serviceId);
}

class ServiceScheduleState extends State<ServiceSchedule>
    with TickerProviderStateMixin {
  AnimationController controller;
  //   controller.duration = Duration(seconds: 3);
  final String employeeId;
  final String serviceId;
  DateRangePickerController _datePickerController = DateRangePickerController();
  final SchedulesWebClient _webclient = SchedulesWebClient();

  ServiceScheduleState(this.employeeId, this.serviceId);

  DateTime dateStart;
  DateTime dateEnd;

  @override
  initState() {
    super.initState();
    controller = BottomSheet.createAnimationController(this);
    controller.duration = Duration(seconds: 2);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6F3EE),
      appBar: AppBar(
        title: Text(
          'Calendário',
          style: GoogleFonts.dancingScript(
            textStyle: TextStyle(
              color: Color(0xFFCC39191),
              letterSpacing: .5,
              fontSize: 40,
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              SfDateRangePicker(
                onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
                  // _onSelectedData(args, context, employeeId, serviceId);
                  if (args.value.startDate != null &&
                      args.value.endDate != null) {
                    final DateTime dataDias =
                        args.value.startDate.add(const Duration(days: 15));
                    var difference =
                        args.value.endDate.difference(args.value.startDate);

                    if (difference.inDays <= 15) {
                      setState(() {
                        dateStart = args.value.startDate;
                        dateEnd = args.value.endDate;
                      });
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
                },
                selectionColor: Colors.black,
                view: DateRangePickerView.month,
                // monthFormat: 'LLL',
                monthViewSettings: DateRangePickerMonthViewSettings(
                  showTrailingAndLeadingDates: true,
                ),
                headerStyle: DateRangePickerHeaderStyle(
                  textAlign: TextAlign.left,
                  textStyle: TextStyle(
                    fontStyle: FontStyle.normal,
                    fontSize: 25,
                    letterSpacing: 5,
                    color: Colors.black,
                  ),
                ),
                selectionMode: DateRangePickerSelectionMode.range,
                startRangeSelectionColor: Color(0xFFA1887F),
                endRangeSelectionColor: Color(0xFFA1887F),
                rangeSelectionColor: Color(0xFFCC39191),
                todayHighlightColor: Color(0xFFCC39191),
                rangeTextStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
                minDate: DateTime.now(),
                controller: _datePickerController,
              ),
              Container(
                margin: const EdgeInsets.only(top: 20, left: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Dias e Horários',
                      style: GoogleFonts.dancingScript(
                        textStyle: TextStyle(
                          color: Color(0xFFCC39191),
                          letterSpacing: .5,
                          fontSize: 40,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
              ),
              Divider(
                height: 20,
                thickness: 1,
                indent: 20,
                endIndent: 20,
              ),
              Flexible(
                child: Container(
                  margin: EdgeInsets.all(15),
                  child: Scrollbar(
                    thickness: 3,
                    child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: FutureBuilder<List>(
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
                                  final List<Schedule> schedules =
                                      snapshot.data;
                                  if (schedules.isNotEmpty) {
                                    return GridView.builder(
                                      shrinkWrap: true,
                                      physics: BouncingScrollPhysics(),
                                      itemCount:
                                          schedules[0].intervalFinal.length,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        childAspectRatio: 1,
                                        crossAxisCount: 3,
                                        crossAxisSpacing: 35.0,
                                        mainAxisSpacing: 35.0,
                                      ),
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return TextButton(
                                          child: Text(
                                            schedules[0]
                                                .intervalFinal[index]
                                                .date,
                                            style: TextStyle(fontSize: 10),
                                          ),
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(
                                              Color(0xFFF0EBE1),
                                            ),
                                            foregroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(Color(0xFFCC39191)),
                                            shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20.0),
                                              ),
                                            ),
                                          ),
                                          onPressed: () {
                                            _showModalSechedules(
                                                context,
                                                schedules[0]
                                                    .intervalFinal[index]
                                                    .times,
                                                schedules[0]
                                                    .intervalFinal[index]
                                                    .date,
                                                schedules);
                                          },
                                        );
                                      },
                                    );
                                  }
                                }
                                return Empty(
                                  title: 'Sem datas disponíveis',
                                  subtitle:
                                      'Informe os dias no calendário acima para pesquisa.',
                                  image: PackageImage.Image_1,
                                  button: false,
                                  textButton: 'Recarregar',
                                  textState: null,
                                  function: () => null,
                                );
                              // return Center(
                              //   child: EmptyWidget(
                              //     image: null,
                              //     packageImage: PackageImage.Image_1,
                              //     title: 'Sem datas disponíveis',
                              //     subTitle:
                              //         'Informe os dias no calendário acima para pesquisa.',
                              //     hideBackgroundAnimation: true,
                              //     titleTextStyle: TextStyle(
                              //       fontSize: 22,
                              //       color: Color(0xFFCC39191),
                              //       fontWeight: FontWeight.w500,
                              //     ),
                              //     subtitleTextStyle: TextStyle(
                              //       fontSize: 14,
                              //       color: Color(0xFFCC39191),
                              //     ),
                              //   ),
                              // );
                            }
                            return Text('Elaia 2');
                          },
                        )),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  String groupValueRadioList;

  void _showModalSechedules(
      BuildContext context, List times, String date, List<Schedule> schedules) {
    showModalBottomSheet(
      context: context,
      elevation: 5,
      useRootNavigator: true,
      isScrollControlled: true,
      isDismissible: true,
      transitionAnimationController: controller,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20.0),
        ),
      ),
      builder: (BuildContext contextBottomSheet) {
        groupValueRadioList = null;

        return Padding(
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(contextBottomSheet).viewInsets.bottom),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.90,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                TitleBottomSheet(
                  title: "Escolha o horário para o dia $date: ",
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    letterSpacing: 0.4,
                    color: Color(0xFFCC39191),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Expanded(
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemCount: times.length,
                      itemBuilder: (contextList, index) {
                        return Theme(
                          data: ThemeData(
                            unselectedWidgetColor: Color(0xFFCC39191),
                          ),
                          child: RadioListTile<String>(
                            title: Text(times[index]),
                            value: times[index],
                            groupValue: groupValueRadioList,
                            onChanged: (String choice) {
                              print('Revisao');
                              setState(() {
                                groupValueRadioList = choice;
                              });

                              Navigator.push(
                                context,
                                MaterialPageRoute<void>(
                                  builder: (BuildContext context) => Revision(
                                      date,
                                      groupValueRadioList,
                                      schedules,
                                      employeeId,
                                      serviceId),
                                  fullscreenDialog: true,
                                ),
                              );
                            },
                            // ignore: unrelated_type_equality_checks
                            selected: groupValueRadioList == index,
                            toggleable: true,
                            secondary: Icon(Icons.access_time),
                            controlAffinity: ListTileControlAffinity.trailing,
                            activeColor: Colors.amber[800],
                          ),
                        );
                      },
                    ),
                  ),
                ),
                // _expandedListDate(
                //     context, times, setState, employeeId, serviceId),
              ],
            ),
          ),
        );
      },
    );
  }
}
