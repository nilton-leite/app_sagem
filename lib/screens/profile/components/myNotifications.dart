import 'package:app_sagem/components/empty.dart';
import 'package:app_sagem/components/progress.dart';
import 'package:app_sagem/http/webclients/notifications.dart';
import 'package:app_sagem/models/notifications.dart';
import 'package:empty_widget/empty_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class MyNotifications extends StatefulWidget {
  const MyNotifications({
    Key key,
  }) : super(key: key);

  @override
  _MyNotificationsState createState() => _MyNotificationsState();
}

class _MyNotificationsState extends State<MyNotifications> {
  List<Notifications> notifications = [];
  final NotificationsWebClient _webclient = NotificationsWebClient();

  GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6F3EE),
      appBar: AppBar(
        titleSpacing: 0,
        automaticallyImplyLeading: true,
        title: Text(
          'Minhas Notificações',
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
        future: _webclient?.getNotifications(),
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
                notifications = snapshot.data;
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                    ),
                    Container(
                      padding: EdgeInsets.all(5),
                      width: double.infinity,
                      child: RefreshIndicator(
                        // ignore: missing_return
                        onRefresh: () {
                          setState(() {});
                        },
                        key: _refreshIndicatorKey,
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: notifications.length,
                          itemBuilder: (context, index) {
                            final item = notifications[index];

                            return Column(
                              children: [
                                Align(
                                  alignment: FractionalOffset(0.1, 0.0),
                                  child: Text(
                                    DateFormat("d 'de' MMMM 'de' y", "pt_BR")
                                        .format(
                                      DateFormat('dd/MM/yyyy')
                                          .parse(item.dateInsert),
                                    ),
                                    style: GoogleFonts.dancingScript(
                                      textStyle: TextStyle(
                                        color: Color(0xFFCC39191),
                                        letterSpacing: .5,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ),
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  itemCount:
                                      notifications[index].messages.length,
                                  itemBuilder: (context, indexMessage) {
                                    final itemMessage = notifications[index]
                                        .messages[indexMessage];

                                    return Column(
                                      children: [
                                        ListTile(
                                          leading:
                                              Icon(Icons.circle_notifications),
                                          title: Text(itemMessage.title),
                                          subtitle: Text(itemMessage.body),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                );
              }
              return Empty(
                title: 'Sem agendamentos',
                subtitle: 'Não encontramos agendamentos pendentes!',
                image: PackageImage.Image_3,
                button: false,
              );
          }
          return Empty(
            title: 'Ops... Sem internet',
            subtitle: 'Verifique sua conexão com a internet e tente de novo',
            image: PackageImage.Image_2,
            button: false,
            textState: null,
          );
        },
      ),
    );
  }
}

/// The base class for the different types of items the list can contain.
abstract class ListItem {
  /// The title line to show in a list item.
  Widget buildTitle(BuildContext context);

  /// The subtitle line, if any, to show in a list item.
  Widget buildSubtitle(BuildContext context);
}

/// A ListItem that contains data to display a heading.
class HeadingItem implements ListItem {
  final String heading;

  HeadingItem(this.heading);

  @override
  Widget buildTitle(BuildContext context) {
    return Text(
      heading,
      style: Theme.of(context).textTheme.headline5,
    );
  }

  @override
  Widget buildSubtitle(BuildContext context) => const SizedBox.shrink();
}

/// A ListItem that contains data to display a message.
class MessageItem implements ListItem {
  final String sender;
  final String body;

  MessageItem(this.sender, this.body);

  @override
  Widget buildTitle(BuildContext context) => Text(sender);

  @override
  Widget buildSubtitle(BuildContext context) => Text(body);
}
