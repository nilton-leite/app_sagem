import 'package:app_sagem/components/title_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class ServiceSchedule extends StatefulWidget {
  @override
  ServiceScheduleState createState() => ServiceScheduleState();
}

class ServiceScheduleState extends State<ServiceSchedule> {
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
          Positioned(
            left: 0,
            top: 0,
            right: 0,
            bottom: 0,
            child: SfDateRangePicker(
              onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
                if (args.value.startDate != null &&
                    args.value.endDate != null) {
                  showModalBottomSheet(
                    context: context,
                    // elevation: 24,
                    // useRootNavigator: true,
                    isScrollControlled: false,
                    // isDismissible: true,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20.0),
                      ),
                    ),
                    builder: (BuildContext contextBottomSheet) {
                      return Padding(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(contextBottomSheet)
                                .viewInsets
                                .bottom),
                        child: Container(
                          height: MediaQuery.of(context).size.height,
                          child: Column(
                            children: <Widget>[
                              TitleBottomSheet(title: "Horários"),
                              Container(
                                child: Wrap(
                                  children: <Widget>[
                                    ListTile(
                                        leading: new Icon(Icons.music_note),
                                        title: new Text('Músicas'),
                                        onTap: () => {}),
                                    ListTile(
                                      leading: new Icon(Icons.videocam),
                                      title: new Text('Videos'),
                                      onTap: () => {},
                                    ),
                                    ListTile(
                                      leading: new Icon(Icons.satellite),
                                      title: new Text('Tempo'),
                                      onTap: () => {},
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
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
            ),
          )
        ],
      ),
    );
  }
}



// import 'package:flutter/material.dart';

// import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
//     show CalendarCarousel;
// import 'package:flutter_calendar_carousel/classes/event.dart';
// import 'package:flutter_calendar_carousel/classes/event_list.dart';
// import 'package:intl/intl.dart';

// class ServiceSchedule extends StatefulWidget {
//   ServiceSchedule({Key key, this.title}) : super(key: key);

//   // This widget is the home page of your application. It is stateful, meaning
//   // that it has a State object (defined below) that contains fields that affect
//   // how it looks.

//   // This class is the configuration for the state. It holds the values (in this
//   // case the title) provided by the parent (in this case the App widget) and
//   // used by the build method of the State. Fields in a Widget subclass are
//   // always marked "final".

//   final String title;

//   @override
//   _ServiceScheduleState createState() => new _ServiceScheduleState();
// }

// class _ServiceScheduleState extends State<ServiceSchedule> {
//   DateTime _currentDate = DateTime.now(); //DateTime(2019, 2, 3);
//   DateTime _currentDate2 = DateTime.now();
//   String _currentMonth = DateFormat.yMMM().format(DateTime.now());

//   CalendarCarousel _calendarCarouselNoHeader;

//   @override
//   Widget build(BuildContext context) {
//     /// Example Calendar Carousel without header and custom prev & next button
//     _calendarCarouselNoHeader = CalendarCarousel<Event>(
//       todayBorderColor: Colors.black,
//       onDayPressed: (DateTime date, List<Event> events) {
//         print('Aqui no dia $date');
//         this.setState(() => _currentDate2 = date);
//         events.forEach((event) => print(event.title));
//       },
//       daysHaveCircularBorder: true,
//       weekendTextStyle: TextStyle(
//         color: Colors.red,
//       ),
//       thisMonthDayBorderColor: Colors.grey,
//       weekFormat: false,
//       height: 420.0,
//       selectedDateTime: _currentDate2,
//       customGridViewPhysics: NeverScrollableScrollPhysics(),
//       markedDateCustomShapeBorder:
//           CircleBorder(side: BorderSide(color: Colors.amber[800])),
//       markedDateCustomTextStyle: TextStyle(
//         fontSize: 18,
//         color: Colors.blue,
//       ),
//       showHeader: false,
//       locale: 'pt',
//       todayTextStyle: TextStyle(
//         color: Colors.black,
//       ),
//       todayButtonColor: Colors.amber[800],
//       selectedDayTextStyle: TextStyle(
//         color: Colors.white,
//       ),
//       selectedDayButtonColor: Colors.pinkAccent,
//       minSelectedDate: _currentDate.subtract(Duration(days: 360)),
//       maxSelectedDate: _currentDate.add(Duration(days: 360)),
//       prevDaysTextStyle: TextStyle(
//         fontSize: 16,
//         color: Colors.pinkAccent,
//       ),
//       inactiveDaysTextStyle: TextStyle(
//         color: Colors.tealAccent,
//         fontSize: 16,
//       ),
//       onCalendarChanged: (DateTime date) {
//         this.setState(() => _currentMonth = DateFormat.yMMM().format(date));
//       },
//       onDayLongPressed: (DateTime date) {
//         print('long pressed date $date');
//       },
//     );

//     return new Scaffold(
//         appBar: new AppBar(
//           centerTitle: true,
//           title: new Text(
//             'Agendamentos',
//             style: Theme.of(context).appBarTheme.titleTextStyle,
//           ),
//         ),
//         body: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: <Widget>[
//               Container(
//                 margin: EdgeInsets.only(
//                   top: 30.0,
//                   bottom: 16.0,
//                   left: 16.0,
//                   right: 16.0,
//                 ),
//                 child: new Row(
//                   children: <Widget>[
//                     Expanded(
//                         child: Text(
//                       _currentMonth,
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 24.0,
//                       ),
//                     )),
//                     ElevatedButton(
//                       child: Text('PREV'),
//                       onPressed: () {
//                         setState(() {
//                           _currentDate2 =
//                               _currentDate2.subtract(Duration(days: 30));
//                           _currentMonth =
//                               DateFormat.yMMM().format(_currentDate2);
//                         });
//                       },
//                     ),
//                     ElevatedButton(
//                       child: Text('NEXT'),
//                       onPressed: () {
//                         setState(() {
//                           _currentDate2 = _currentDate2.add(Duration(days: 30));
//                           _currentMonth =
//                               DateFormat.yMMM().format(_currentDate2);
//                         });
//                       },
//                     )
//                   ],
//                 ),
//               ),
//               Container(
//                 margin: EdgeInsets.symmetric(horizontal: 16.0),
//                 child: _calendarCarouselNoHeader,
//               ), //
//             ],
//           ),
//         ));
//   }
// }
