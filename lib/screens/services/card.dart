import 'package:app_sagem/components/dynamic_icon.dart';
import 'package:app_sagem/components/title_bottom_sheet.dart';
import 'package:app_sagem/models/service.dart';
import 'package:app_sagem/screens/services/service_schedule.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardService extends StatefulWidget {
  final List<Service> services;
  final TextStyle optionStyle;
  const CardService({
    Key key,
    this.services,
    this.optionStyle,
  }) : super(key: key);

  @override
  _CardServiceState createState() =>
      _CardServiceState(this.optionStyle, this.services);
}

class _CardServiceState extends State<CardService> {
  final List<Service> services;
  final TextStyle optionStyle;
  _CardServiceState(this.optionStyle, this.services);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 300,
          childAspectRatio: 3 / 3,
          crossAxisSpacing: 20,
          mainAxisSpacing: 10),
      itemBuilder: (contextGrid, index) {
        final Service service = services[index];
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            child: InkWell(
              onTap: () {
                _showModalBottomSheet(context, service);
              },
              child: Card(
                semanticContainer: true,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(
                    color: Colors.grey.withOpacity(0.5),
                    width: 2,
                  ),
                ),
                color: Colors.white,
                child: Center(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        DynamicIcon(
                          services[index].icon,
                          color: Colors.amber[800],
                          size: 50.0,
                        ),
                        // Icon(Icons.ac_unit_rounded, size: 80.0, color: Colors.amber[800]),
                        Text(
                          services[index].title,
                          style: optionStyle,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
      itemCount: services.length,
    );
  }

  String groupValueRadioList;

  void _showModalBottomSheet(BuildContext context, Service service) {
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
      builder: (BuildContext contextModal) {
        groupValueRadioList = null;
        return StatefulBuilder(
            builder: (BuildContext contextBuilder, StateSetter setState) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(contextBuilder).viewInsets.bottom),
            child: Container(
              height: MediaQuery.of(contextBuilder).size.height * 0.50,
              child: Column(
                children: <Widget>[
                  TitleBottomSheet(title: service.title),
                  _listViewBottomSheet(service, setState),
                  _buttonBottomSheet(context),
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
        child: new Wrap(
          children: <Widget>[
            ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: service.employees.length,
              itemBuilder: (context, index) {
                return Theme(
                  data: ThemeData(
                    unselectedWidgetColor: Colors.amber[800],
                  ),
                  child: RadioListTile<String>(
                    title: Text(service.employees[index].fullName),
                    value: service.employees[index].id,
                    groupValue: groupValueRadioList,
                    onChanged: (String choice) {
                      setState(() {
                        groupValueRadioList = choice;
                      });
                    },
                    // ignore: unrelated_type_equality_checks
                    selected: groupValueRadioList == index,
                    toggleable: true,
                    subtitle: Text(
                        service.employees[index].description ?? 'A seu dispor'),
                    secondary: Icon(Icons.person),
                    controlAffinity: ListTileControlAffinity.trailing,
                    activeColor: Colors.amber[800],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Center _buttonBottomSheet(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          SizedBox(
            width: 400,
            child: ElevatedButton(
              onPressed: () {
                print('Oie amigo $groupValueRadioList');
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ServiceSchedule(),
                  ),
                );
              },
              child: Text("Continuar"),
              style: ElevatedButton.styleFrom(
                primary: Colors.amber[800],
                elevation: 1, //elevation of button
                shape: RoundedRectangleBorder(
                    //to set border radius to button
                    borderRadius: BorderRadius.circular(10)),
                padding: EdgeInsets.all(15),
              ),
            ),
          )
        ],
      ),
    );
  }
}
