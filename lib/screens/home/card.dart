import 'package:app_sagem/components/dynamic_icon.dart';
import 'package:app_sagem/models/schedules_home.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CardHome extends StatefulWidget {
  final List<ScheduleHome> scheduleHome;
  final TextStyle optionStyle;
  const CardHome({
    Key key,
    this.scheduleHome,
    this.optionStyle,
  }) : super(key: key);

  @override
  _CardHomeState createState() =>
      _CardHomeState(this.optionStyle, this.scheduleHome);
}

class _CardHomeState extends State<CardHome> {
  final List<ScheduleHome> scheduleHome;
  final TextStyle optionStyle;
  _CardHomeState(this.optionStyle, this.scheduleHome);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6F3EE),
      body: SingleChildScrollView(
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
            Center(
              child: SizedBox(
                width: 350,
                child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    hintStyle: TextStyle(color: Color(0xFFCC39191)),
                    hintText: "Pesquise",
                    labelText: 'Pesquise...',
                    suffixIcon: IconButton(
                      onPressed: () {
                        print('Clicou');
                      },
                      icon: Icon(Icons.search),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 20.0),
              height: 50.0,
              child: new ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(left: 20),
                    child: TextButton(
                      child: Text(
                        "Makeup",
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
                            // side: BorderSide(color: Colors.black),
                          ),
                        ),
                      ),
                      onPressed: () => null,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 20),
                    child: TextButton(
                      child: Text(
                        "Sobrancelha",
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
                            borderRadius: BorderRadius.circular(18.0),
                            // side: BorderSide(color: Colors.black),
                          ),
                        ),
                      ),
                      onPressed: () => null,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 20),
                    child: TextButton(
                      child: Text(
                        "Mão + Pé",
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
                          Color(0xFFCC39191),
                        ),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            // side: BorderSide(color: Colors.black),
                          ),
                        ),
                      ),
                      onPressed: () => null,
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              height: 20,
              thickness: 1,
              indent: 20,
              endIndent: 20,
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: scheduleHome.length,
              padding: const EdgeInsets.only(top: 10.0),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: InkWell(
                    onTap: () {
                      print('Teste');
                    },
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
                              scheduleHome[index].services[0].icon,
                              color: Colors.amber[800],
                              size: 30.0,
                            ),
                            leading: TextButton(
                              child: Text(
                                scheduleHome[index].services[0].title,
                                style: TextStyle(fontSize: 14),
                              ),
                              style: ButtonStyle(
                                padding: MaterialStateProperty.all<EdgeInsets>(
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
                            // DynamicIcon(
                            //   scheduleHome[index].services[0].icon,
                            //   color: Colors.amber[800],
                            //   size: 30.0,
                            // ),
                            // title:
                            //     Text(scheduleHome[index].services[0].title),
                            // subtitle: Text(
                            //   scheduleHome[index].services[0].description,
                            //   style: TextStyle(
                            //       color: Colors.black.withOpacity(0.6)),
                            // ),
                          ),
                          ListTile(
                            // leading: Icon(Icons.arrow_drop_down_circle),
                            title:
                                Text(scheduleHome[index].employees[0].fullName),
                            subtitle: Text(
                              UtilBrasilFields.obterCpf(
                                      scheduleHome[index].employees[0].cpf) +
                                  ' / ' +
                                  UtilBrasilFields.obterTelefone(
                                      scheduleHome[index]
                                          .employees[0]
                                          .telephone),
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.6)),
                            ),
                          ),
                          ListTile(
                            // leading: Icon(Icons.arrow_drop_down_circle),
                            title: Text(scheduleHome[index].dataSchedule),
                            subtitle: Text(
                              scheduleHome[index].time,
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.6)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
