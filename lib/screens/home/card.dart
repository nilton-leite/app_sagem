import 'package:app_sagem/components/dynamic_icon.dart';
import 'package:app_sagem/components/progress.dart';
import 'package:app_sagem/http/webclients/schedules.dart';
import 'package:app_sagem/http/webclients/services.dart';
import 'package:app_sagem/models/schedules_home.dart';
import 'package:app_sagem/models/service.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:empty_widget/empty_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CardHome extends StatefulWidget {
  @override
  _CardHomeState createState() => _CardHomeState();
}

class _CardHomeState extends State<CardHome> {
  static final TextEditingController _search = new TextEditingController();

  String get searchText => _search.text;
  String serviceId;
  GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  final SchedulesWebClient _webclient = SchedulesWebClient();
  final ServicesWebClient _webclientService = ServicesWebClient();
  List<ScheduleHome> scheduleHome = [];

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
                      _searchSchedules(),
                      _filterServicesSchedules(),
                      Divider(
                        height: 20,
                        thickness: 1,
                        indent: 20,
                        endIndent: 20,
                      ),
                      _cardsSchedules(),
                    ],
                  );
                }
                return Text('Elaia');
            }
            return Text('Elaia 2');
          },
        ));
  }

  Center _searchSchedules() {
    return Center(
      child: SizedBox(
        width: 350,
        child: TextField(
          controller: _search,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Color(0xFFCC39191),
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(25.0),
            ),
            hintStyle: TextStyle(color: Color(0xFFCC39191)),
            hintText: "Nome da atendente...",
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  searchText;
                });
              },
              icon: Icon(Icons.search),
              focusColor: Color(0xFFCC39191),
              color: Color(0xFFCC39191),
            ),
          ),
        ),
      ),
    );
  }

  Widget _filterServicesSchedules() {
    return FutureBuilder<List>(
      initialData: [],
      future: _webclientService?.findAll(),
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
              final List<Service> services = snapshot.data;
              Map<String, dynamic> todes = {
                "id": null,
                "title": "Todos",
                "description": "Pare de ser um mecanico",
                "price": 30,
                "executionTime": 5,
                "icon": "blur_circular_sharp",
                "employees": []
              };
              Service teste = Service.fromJson(todes);
              services.insert(0, teste);
              return Container(
                margin: EdgeInsets.symmetric(vertical: 20.0),
                height: 50.0,
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: services.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: const EdgeInsets.only(left: 20),
                      child: TextButton(
                        child: Text(
                          services[index].title,
                          style: TextStyle(fontSize: 14),
                        ),
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all<EdgeInsets>(
                            EdgeInsets.all(10),
                          ),
                          backgroundColor: MaterialStateProperty.all<Color>(
                            Color(0xFFF0EBE1),
                          ),
                          foregroundColor: MaterialStateProperty.all<Color>(
                              Color(0xFFCC39191)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                        ),
                        onPressed: () {
                          serviceId = services[index].id;
                          setState(() {
                            // ignore: unnecessary_statements
                            serviceId;
                          });
                        },
                      ),
                    );
                  },
                ),
              );
            }
            return Text('Elaia');
        }
        return Text('Elaia 2');
      },
    );
  }

  Widget _cardsSchedules() {
    if (scheduleHome.length > 0) {
      return Flexible(
        child: Container(
          padding: EdgeInsets.all(5),
          width: double.infinity,
          child: RefreshIndicator(
              key: _refreshIndicatorKey,
              child: ListView.builder(
                shrinkWrap: true,
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: scheduleHome.length,
                padding: const EdgeInsets.only(top: 10.0),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: InkWell(
                      onTap: () => null,
                      child: Card(
                        color: Color(0xFFFBFBFB),
                        clipBehavior: Clip.antiAlias,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Column(
                          children: [
                            ListTile(
                              trailing: DynamicIcon(
                                scheduleHome[index].services['icon'],
                                color: Color(0xFFCC39191),
                                size: 30.0,
                              ),
                              leading: TextButton(
                                child: Text(
                                  scheduleHome[index].services['title'],
                                  style: TextStyle(fontSize: 14),
                                ),
                                style: ButtonStyle(
                                  padding:
                                      MaterialStateProperty.all<EdgeInsets>(
                                    EdgeInsets.all(10),
                                  ),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                    Color(0xFFF0EBE1),
                                  ),
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Color(0xFFCC39191)),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                      // side: BorderSide(color: Colors.black),
                                    ),
                                  ),
                                ),
                                onPressed: () => null,
                              ),
                            ),
                            ListTile(
                              // leading: Icon(Icons.arrow_drop_down_circle),
                              title: Text(
                                  scheduleHome[index].employees['full_name']),
                              subtitle: Text(
                                UtilBrasilFields.obterCpf(
                                        scheduleHome[index].employees['cpf']) +
                                    ' / ' +
                                    UtilBrasilFields.obterTelefone(
                                        scheduleHome[index]
                                            .employees['telephone']),
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.6)),
                              ),
                            ),
                            ListTile(
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  TextButton(
                                    child: Text(
                                      "Cancelar",
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    style: ButtonStyle(
                                      padding:
                                          MaterialStateProperty.all<EdgeInsets>(
                                        EdgeInsets.all(10),
                                      ),
                                      foregroundColor: MaterialStateProperty
                                          .resolveWith<Color>(
                                        (Set<MaterialState> states) {
                                          if (states
                                              .contains(MaterialState.pressed))
                                            return Colors.green;
                                          else if (states
                                              .contains(MaterialState.disabled))
                                            return Colors.redAccent
                                                .withOpacity(0.10);
                                          return Colors
                                              .redAccent; // Use the component's default.
                                        },
                                      ),
                                    ),
                                    onPressed: !scheduleHome[index].cancel
                                        ? null
                                        : () async {
                                            print('Cancelar aqui');
                                            Map<String, dynamic> cancel =
                                                await _webclient.cancel(
                                                    scheduleHome[index].id);
                                            print(cancel);

                                            if (!cancel['status']) {
                                              final snackBar = SnackBar(
                                                content:
                                                    Text(cancel['message']),
                                                backgroundColor:
                                                    Colors.redAccent,
                                              );

                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(snackBar);
                                            } else {
                                              final snackBar = SnackBar(
                                                content:
                                                    Text(cancel['message']),
                                                backgroundColor:
                                                    Color(0xFFCC39191),
                                              );

                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(snackBar);

                                              setState(() {
                                                searchText;
                                              });
                                            }
                                          },
                                  ),
                                ],
                              ),
                              title: Text(scheduleHome[index].dataSchedule +
                                  ' ás ' +
                                  scheduleHome[index].time),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
              onRefresh: _refreshCards),
        ),
      );
    } else {
      return Column(
        children: [
          Center(
            child: EmptyWidget(
              image: null,
              packageImage: PackageImage.Image_3,
              title: 'Sem agendamentos',
              subTitle: 'Não encontramos agendamentos pendentes!',
              hideBackgroundAnimation: true,
              titleTextStyle: TextStyle(
                fontSize: 22,
                color: Color(0xFFCC39191),
                fontWeight: FontWeight.w500,
              ),
              subtitleTextStyle: TextStyle(
                fontSize: 14,
                color: Color(0xFFCC39191),
              ),
            ),
          ),
          Center(
            child: ElevatedButton(
              child: Text('Recarregar'),
              style: ElevatedButton.styleFrom(
                primary: Color(0xFFCC39191),
                elevation: 1,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                padding: EdgeInsets.all(15),
              ),
              onPressed: () {
                setState(() {
                  searchText;
                });
              },
            ),
          ),
        ],
      );
    }
  }

  Future<void> _refreshCards() async {
    setState(() {
      searchText;
    });
  }
}
