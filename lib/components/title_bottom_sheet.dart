import 'package:flutter/material.dart';

class TitleBottomSheet extends StatelessWidget {
  final String title;
  final TextStyle style;
  const TitleBottomSheet({Key key, this.title, this.style}) : super(key: key);

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
            style: style,
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
