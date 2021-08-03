import 'package:app_sagem/models/services.dart';
import 'package:flutter/material.dart';

// class Option {
//   const Option({this.titulo, this.icon});
//   final String titulo;
//   final IconData icon;
// }

class ServicesCard extends StatelessWidget {
  final Service option;
  const ServicesCard({Key key, this.option}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('NO CARD');
    print(option.title);
    const TextStyle optionStyle = TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.bold,
    );
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        height: 500,
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
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.directions_car,
                    size: 80.0, color: Colors.amber[800]),
                Text(
                  option.title,
                  style: optionStyle,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
