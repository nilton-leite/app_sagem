import 'package:app_sagem/components/progress.dart';
import 'package:app_sagem/http/webclients/services.dart';
import 'package:app_sagem/models/service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ServicesHome extends StatefulWidget {
  final Function(String, int) function;

  const ServicesHome({Key key, this.function}) : super(key: key);
  @override
  _ServicesHomeState createState() => _ServicesHomeState();
}

class _ServicesHomeState extends State<ServicesHome> {
  final ServicesWebClient _webclientService = ServicesWebClient();
  String serviceId;

  @override
  Widget build(BuildContext context) {
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
                          return widget.function(services[index].id, 1);
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
}
