import 'package:flutter/material.dart';

class Option {
  const Option({required this.titulo, required this.icon});
  final String titulo;
  final IconData icon;
}

class ServicesCard extends StatelessWidget {
  final Option option;
  const ServicesCard({Key? key, required this.option}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
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
                Icon(option.icon, size: 80.0, color: Colors.black),
                Text(option.titulo),
              ],
            ),
          )),
    );
  }
}
