import 'package:app_sagem/components/customDialogBox.dart';
import 'package:app_sagem/components/empty.dart';
import 'package:app_sagem/components/progress.dart';
import 'package:app_sagem/http/webclients/schedules.dart';
import 'package:app_sagem/models/schedules_home.dart';
import 'package:app_sagem/screens/home/components/card.dart';
import 'package:app_sagem/screens/home/components/search.dart';
import 'package:app_sagem/screens/home/components/services.dart';
import 'package:empty_widget/empty_widget.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
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

  final SchedulesWebClient _webclient = SchedulesWebClient();
  List<ScheduleHome> scheduleHome = [];
  FirebaseMessaging messaging;

  callback(newValue, type) {
    print('AQUI AIMIGO');
    setState(() {
      if (type == 0) searchText = newValue;
      if (type == 1) serviceId = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    messaging = FirebaseMessaging.instance;

    messaging.getToken().then((value) {
      print(value);
    });
    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      print('OIE'); // showDialog(
      //   context: context,
      //   builder: (BuildContext contextDialog) {
      //     return CustomDialogBox(
      //         title: event.notification.title,
      //         descriptions: event.notification.body,
      //         textConfirm: "Fechar",
      //         textCancel: "Não",
      //         function: () async {
      //           Navigator.of(context).pop();
      //         });
      //   },
      // );
    });
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print('Message clicked!');
    });

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
                    Container(
                      child: CardHome(
                        scheduleHome: scheduleHome,
                        searchText: searchText,
                        isEmpty: scheduleHome.length > 0 ? false : true,
                        function: callback,
                      ),
                    ),
                    // _cardsSchedules(),
                  ],
                );
              }
              return Empty(
                title: 'Ops... Verifique sua conexão com a internet',
                subtitle: 'Não conseguimos buscar as informações!',
                image: PackageImage.Image_3,
                button: false,
                textButton: '',
                textState: null,
              );
          }
          return Empty(
            title: 'Ops... Verifique sua conexão com a internet',
            subtitle: 'Não conseguimos buscar as informações!',
            image: PackageImage.Image_3,
            button: false,
            textButton: '',
            textState: null,
          );
        },
      ),
    );
  }
}
