import 'package:app_sagem/components/progress.dart';
import 'package:app_sagem/http/webclients/schedules.dart';
import 'package:app_sagem/models/schedules_home.dart';
import 'package:app_sagem/screens/home/components/card.dart';
import 'package:app_sagem/screens/home/components/search.dart';
import 'package:app_sagem/screens/home/components/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IndexHome extends StatefulWidget {
  @override
  _IndexHomeState createState() => _IndexHomeState();
}

class _IndexHomeState extends State<IndexHome> {
  String searchText;
  String serviceId;
  GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  final SchedulesWebClient _webclient = SchedulesWebClient();
  List<ScheduleHome> scheduleHome = [];

  callback(newValue, type) {
    setState(() {
      if (type == 0) searchText = newValue;
      if (type == 1) serviceId = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6F3EE),
      body: FutureBuilder<List>(
        initialData: [],
        future: _webclient?.findSchedulesHome(searchText, serviceId),
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
                scheduleHome = snapshot.data;
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 40, left: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Agendamentos',
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
                    Search(function: callback),
                    ServicesHome(function: callback),
                    Divider(
                      height: 20,
                      thickness: 1,
                      indent: 20,
                      endIndent: 20,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Container(
                          child: CardHome(
                            scheduleHome: scheduleHome,
                            searchText: searchText,
                            isEmpty: scheduleHome.length > 0 ? false : true,
                            function: callback,
                          ),
                        ),
                      ),
                    ),
                    // _cardsSchedules(),
                  ],
                );
              }
              return Text('Elaia');
          }
          return Text('Elaia 2');
        },
      ),
    );
  }
}
