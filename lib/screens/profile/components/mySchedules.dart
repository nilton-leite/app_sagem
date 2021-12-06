import 'package:app_sagem/components/empty.dart';
import 'package:app_sagem/components/progress.dart';
import 'package:app_sagem/http/webclients/schedules.dart';
import 'package:app_sagem/models/schedules_home.dart';
import 'package:app_sagem/screens/home/components/card.dart';
import 'package:app_sagem/screens/home/components/search.dart';
import 'package:app_sagem/screens/home/components/services.dart';
import 'package:empty_widget/empty_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MySchedules extends StatefulWidget {
  final List<ScheduleHome> scheduleHome;
  final bool isEmpty;
  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey;
  final String searchText;
  final TextEditingController search;
  final Function() refresh;
  const MySchedules(
      {Key key,
      this.scheduleHome,
      this.isEmpty,
      this.refreshIndicatorKey,
      this.searchText,
      this.search,
      this.refresh})
      : super(key: key);

  @override
  _MySchedulesState createState() => _MySchedulesState();
}

class _MySchedulesState extends State<MySchedules> {
  String searchText = '';
  String serviceId = '';

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
      appBar: AppBar(
        titleSpacing: 0,
        automaticallyImplyLeading: true,
        title: Text(
          'Meus Agendamentos',
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
      body: FutureBuilder<List>(
        initialData: [],
        future: _webclient?.findMySchedules(searchText, serviceId),
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
                    )
                    // _cardsSchedules(),
                  ],
                );
              }
              return Empty(
                title: 'Sem agendamentos',
                subtitle: 'Não encontramos agendamentos pendentes!',
                image: PackageImage.Image_3,
                button: true,
                textButton: 'Recarregar',
                textState: null,
                function: () {
                  widget.refresh();
                },
              );
          }
          return Empty(
            title: 'Ops... Sem internet',
            subtitle: 'Verifique sua conexão com a internet e tente de novo',
            image: PackageImage.Image_2,
            button: true,
            textButton: 'Recarregar',
            textState: null,
            function: () {
              widget.refresh();
            },
          );
        },
      ),
    );
  }
}
