import 'package:app_sagem/components/dynamic_icon.dart';
import 'package:app_sagem/components/empty.dart';
import 'package:app_sagem/http/webclients/schedules.dart';
import 'package:app_sagem/models/schedules_home.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:empty_widget/empty_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardHome extends StatefulWidget {
  final List<ScheduleHome> scheduleHome;
  final bool isEmpty;
  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey;
  final String searchText;
  final TextEditingController search;
  final Function() refresh;
  const CardHome(
      {Key key,
      this.scheduleHome,
      this.isEmpty,
      this.refreshIndicatorKey,
      this.searchText,
      this.search,
      this.refresh})
      : super(key: key);

  @override
  _CardHomeState createState() => _CardHomeState();
}

class _CardHomeState extends State<CardHome> {
  final SchedulesWebClient _webclient = SchedulesWebClient();

  @override
  Widget build(BuildContext context) {
    return widget.isEmpty
        ? Empty(
            title: 'Sem agendamentos',
            subtitle: 'Não encontramos agendamentos pendentes!',
            image: PackageImage.Image_3,
            button: true,
            textButton: 'Recarregar',
            textState: null,
            function: () {
              widget.refresh();
            },
          )
        : Flexible(
            child: Container(
              padding: EdgeInsets.all(5),
              width: double.infinity,
              child: RefreshIndicator(
                  key: widget.refreshIndicatorKey,
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: widget.scheduleHome.length,
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
                                    widget.scheduleHome[index].services['icon'],
                                    color: Color(0xFFCC39191),
                                    size: 30.0,
                                  ),
                                  leading: TextButton(
                                    child: Text(
                                      widget.scheduleHome[index]
                                          .services['title'],
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
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                          // side: BorderSide(color: Colors.black),
                                        ),
                                      ),
                                    ),
                                    onPressed: () => null,
                                  ),
                                ),
                                ListTile(
                                  // leading: Icon(Icons.arrow_drop_down_circle),
                                  title: Text(widget.scheduleHome[index]
                                      .employees['full_name']),
                                  subtitle: Text(
                                    UtilBrasilFields.obterCpf(widget
                                            .scheduleHome[index]
                                            .employees['cpf']) +
                                        ' / ' +
                                        UtilBrasilFields.obterTelefone(widget
                                            .scheduleHome[index]
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
                                          padding: MaterialStateProperty.all<
                                              EdgeInsets>(
                                            EdgeInsets.all(10),
                                          ),
                                          foregroundColor: MaterialStateProperty
                                              .resolveWith<Color>(
                                            (Set<MaterialState> states) {
                                              if (states.contains(
                                                  MaterialState.pressed))
                                                return Colors.green;
                                              else if (states.contains(
                                                  MaterialState.disabled))
                                                return Colors.redAccent
                                                    .withOpacity(0.10);
                                              return Colors
                                                  .redAccent; // Use the component's default.
                                            },
                                          ),
                                        ),
                                        onPressed: !widget
                                                .scheduleHome[index].cancel
                                            ? null
                                            : () async {
                                                print('Cancelar aqui');
                                                Map<String, dynamic> cancel =
                                                    await _webclient.cancel(
                                                        widget
                                                            .scheduleHome[index]
                                                            .id);
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

                                                  widget.refresh();
                                                }
                                              },
                                      ),
                                    ],
                                  ),
                                  title: Text(
                                      widget.scheduleHome[index].dataSchedule +
                                          ' ás ' +
                                          widget.scheduleHome[index].time),
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
  }

  Future<void> _refreshCards() async {
    widget.refresh();
  }
}
