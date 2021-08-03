import 'package:flutter/material.dart';

class TitleBottomSheet extends StatelessWidget {
  final String title;
  const TitleBottomSheet({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        Flexible(
          child: Text(
            this.title,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.amber[800],
            ),
          ),
        ),
        Opacity(
          opacity: 0.0,
          child: IconButton(
            icon: Icon(Icons.clear),
            onPressed: null,
          ),
        ),
      ],
    );
  }
}
