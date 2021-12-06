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
  static final TextEditingController _search = new TextEditingController();

  String get searchText => _search.text;
  String serviceId;
  GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  final SchedulesWebClient _webclient = SchedulesWebClient();
  List<ScheduleHome> scheduleHome = [];

  @override
  void initState() {
    super.initState();
    _search.clear();
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
                return SingleChildScrollView(
                  child: Column(
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
                      Search(
                        function: () {
                          setState(() {
                            searchText;
                          });
                        },
                        search: _search,
                      ),
                      ServicesHome(),
                      Divider(
                        height: 20,
                        thickness: 1,
                        indent: 20,
                        endIndent: 20,
                      ),
                      CardHome(
                        scheduleHome: scheduleHome,
                        searchText: searchText,
                        search: _search,
                        refreshIndicatorKey: _refreshIndicatorKey,
                        isEmpty: scheduleHome.length > 0 ? false : true,
                        refresh: () {
                          setState(() {
                            searchText;
                          });
                        },
                      )
                      // _cardsSchedules(),
                    ],
                  ),
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
