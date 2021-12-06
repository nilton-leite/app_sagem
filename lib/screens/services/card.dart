import 'package:app_sagem/components/dynamic_icon.dart';
import 'package:app_sagem/components/progress.dart';
import 'package:app_sagem/components/title_bottom_sheet.dart';
import 'package:app_sagem/http/webclients/services.dart';
import 'package:app_sagem/models/service.dart';
import 'package:app_sagem/screens/services/service_schedule.dart';
import 'package:empty_widget/empty_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CardService extends StatefulWidget {
  const CardService({
    Key key,
  }) : super(key: key);

  @override
  _CardServiceState createState() => _CardServiceState();
}

class _CardServiceState extends State<CardService>
    with TickerProviderStateMixin {
  AnimationController controller;
  GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  final ServicesWebClient _webclient = ServicesWebClient();

  List<Service> services = [];
  String groupValueRadioList = '';

  Future<void> _refreshServices() async {
    setState(() {});
  }

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
      body: FutureBuilder<List>(
        initialData: [],
        future: _webclient?.findAll(),
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
                services = snapshot.data;
                if (services.isNotEmpty) {
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
                              'Serviços',
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
                      // _expansionServices(),
                      _cardsServices()
                    ],
                  );
                }
              }
              return Text('Elaia');
          }
          return Text('Elaia 2');
        },
      ),
    );
  }

  Widget _cardsServices() {
    if (services.length > 0) {
      return Flexible(
        child: Container(
          padding: EdgeInsets.all(5),
          width: double.infinity,
          child: RefreshIndicator(
              key: _refreshIndicatorKey,
              child: ListView.builder(
                shrinkWrap: true,
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: services.length,
                padding: const EdgeInsets.only(top: 10.0),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: InkWell(
                      onTap: () =>
                          _showModalBottomSheet(context, services[index]),
                      child: Card(
                        color: Color(0xFFFBFBFB),
                        clipBehavior: Clip.antiAlias,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Column(
                          children: [
                            ListTile(
                              leading: DynamicIcon(
                                services[index].icon,
                                color: Color(0xFFCC39191),
                                size: 45.0,
                              ),
                              trailing: Icon(Icons.chevron_right_sharp),
                              title: Text(services[index].title),
                              subtitle: Text(services[index].description),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
              onRefresh: _refreshServices),
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
                setState(() {});
              },
            ),
          ),
        ],
      );
    }
  }

  void _showModalBottomSheet(BuildContext context, Service service) {
    final TextStyle styleTitle = TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.bold,
      color: Color(0xFFCC39191),
    );
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
      builder: (BuildContext contextModal) {
        groupValueRadioList = null;
        return StatefulBuilder(
            builder: (BuildContext contextBuilder, StateSetter setState) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(contextBuilder).viewInsets.bottom),
            child: Container(
              height: MediaQuery.of(contextBuilder).size.height * 0.30,
              child: Column(
                children: <Widget>[
                  TitleBottomSheet(title: service.title, style: styleTitle),
                  _listViewBottomSheet(service, setState),
                ],
              ),
            ),
          );
        });
      },
    );
  }

  Expanded _listViewBottomSheet(Service service, StateSetter setState) {
    return Expanded(
      child: Container(
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: service.employees.length,
          itemBuilder: (context, index) {
            return Theme(
              data: ThemeData(
                unselectedWidgetColor: Color(0xFFCC39191),
              ),
              child: RadioListTile<String>(
                title: Text(service.employees[index].fullName),
                value: service.employees[index].id,
                groupValue: groupValueRadioList,
                onChanged: (String choice) {
                  setState(() {
                    groupValueRadioList = choice;
                  });

                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          ServiceSchedule(groupValueRadioList, service.id),
                    ),
                  );
                },
                // ignore: unrelated_type_equality_checks
                selected: groupValueRadioList == index,
                toggleable: true,
                subtitle: Text(
                    service.employees[index].description ?? 'A seu dispor'),
                secondary: Icon(
                  Icons.person,
                  color: Color(0xFFCC39191),
                  size: 40.0,
                ),
                controlAffinity: ListTileControlAffinity.trailing,
                activeColor: Color(0xFFCC39191),
              ),
            );
          },
        ),
      ),
    );
  }
}
