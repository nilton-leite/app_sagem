import 'package:app_sagem/components/progress.dart';
import 'package:app_sagem/http/webclients/services.dart';
import 'package:flutter/material.dart';

class Services extends StatelessWidget {
  final ServicesWebClient _webclient = ServicesWebClient();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Serviços',
            style: Theme.of(context).appBarTheme.titleTextStyle,
          ),
        ),
        backgroundColor: Colors.blueGrey[50],
        body: FutureBuilder<List>(
            initialData: [],
            future: _webclient.findAll(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  break;
                case ConnectionState.waiting:
                  return Progress();
                case ConnectionState.active:
                  break;
                case ConnectionState.done:
                  // print('snapshot.data');
                  // print(snapshot.data);
                  if (snapshot.hasData) {
                    final List<dynamic> services = snapshot.data;

                    const TextStyle optionStyle = TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    );
                    if (services.isNotEmpty) {
                      return _cardsServices(
                          services: services, optionStyle: optionStyle);
                    }
                  }
                  return Text('Elaia');
              }
              return Text('Elaia 2');
            }));
  }
}

class _cardsServices extends StatelessWidget {
  const _cardsServices({
    Key key,
    @required this.services,
    @required this.optionStyle,
  }) : super(key: key);

  final List services;
  final TextStyle optionStyle;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 300,
          childAspectRatio: 3 / 3,
          crossAxisSpacing: 20,
          mainAxisSpacing: 10),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            child: InkWell(
              onTap: () {
                print("tapped");
                print(services[index]);
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
}

//DynamicIcon('people'),
class DynamicIcon extends Icon {
  DynamicIcon(
    String icon, {
    Key key,
    double size,
    Color color,
    TextDirection textDirection,
  })  : iconName = icon,
        super(
          IconData(
            0,
            fontFamily: 'MaterialIcons',
          ),
          key: key,
          size: size,
          color: color,
          semanticLabel: icon,
          textDirection: textDirection,
        );

  final String iconName;

  @override
  Widget build(BuildContext context) {
    print(size);
    print(color);
    assert(this.textDirection != null || debugCheckHasDirectionality(context));
    final TextDirection textDirection =
        this.textDirection ?? Directionality.of(context);

    final IconThemeData iconTheme = IconTheme.of(context);

    final iconSize = (size ?? iconTheme.size);

    if (icon == null) {
      return Semantics(
        label: semanticLabel,
        child: SizedBox(width: iconSize, height: iconSize),
      );
    }

    final iconOpacity = iconTheme.opacity;
    var iconColor = color ?? iconTheme.color;
    if (iconOpacity != 1.0) {
      iconColor = iconColor.withOpacity(iconColor.opacity * iconOpacity);
    }

    Widget iconWidget = RichText(
      overflow: TextOverflow.visible,
// Never clip.

      textDirection: textDirection,
// Since we already fetched it for the assert...

      text: TextSpan(
        text: iconName,
        style: TextStyle(
          inherit: false,
          color: iconColor,
          fontSize: iconSize,
          fontFamily: icon.fontFamily,
          package: icon.fontPackage,
        ),
      ),
    );

    if (icon.matchTextDirection) {
      switch (textDirection) {
        case TextDirection.rtl:
          iconWidget = Transform(
            transform: Matrix4.identity()..scale(-1.0, 1.0, 1.0),
            alignment: Alignment.center,
            transformHitTests: false,
            child: iconWidget,
          );
          break;
        case TextDirection.ltr:
          break;
      }
    }

    return Semantics(
      label: semanticLabel,
      child: ExcludeSemantics(
        child: SizedBox(
          width: iconSize,
          height: iconSize,
          child: Center(
            child: iconWidget,
          ),
        ),
      ),
    );
  }
}
