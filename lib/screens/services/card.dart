import 'package:app_sagem/components/dynamic_icon.dart';
import 'package:app_sagem/components/title_bottom_sheet.dart';
import 'package:app_sagem/models/service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardService extends StatelessWidget {
  final List<Service> services;
  final TextStyle optionStyle;
  const CardService({
    Key key,
    this.services,
    this.optionStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 300,
          childAspectRatio: 3 / 3,
          crossAxisSpacing: 20,
          mainAxisSpacing: 10),
      itemBuilder: (context, index) {
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

  void _showModalBottomSheet(BuildContext context, Service service) {
    print(service.employees);
    bool _value = false;
    int val = -1;
    showModalBottomSheet(
      context: context,
      elevation: 5,
      isScrollControlled: true,
      isDismissible: false,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20.0),
        ),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.30,
            child: Column(
              children: <Widget>[
                TitleBottomSheet(title: service.title),
                Container(
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
                            child: RadioListTile(
                              title: Text(service.employees[index].fullName),
                              value: 1,
                              groupValue: val,
                              onChanged: (value) {
                                // setState(() {
                                val = value;
                                _value = true;
                                // });
                              },
                              selected: _value,
                              toggleable: true,
                              subtitle: Text(
                                  service.employees[index].description ??
                                      'A seu dispor'),
                              secondary: Icon(Icons.person),
                              controlAffinity: ListTileControlAffinity.trailing,
                            ),
                          );
                        },
                      )
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
}
