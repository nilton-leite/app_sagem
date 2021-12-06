import 'package:empty_widget/empty_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Empty extends StatefulWidget {
  final String title;
  final String subtitle;
  final PackageImage image;
  final bool button;
  final String textButton;
  final String textState;
  final Function() function;
  const Empty(
      {Key key,
      this.title,
      this.subtitle,
      this.image,
      this.button,
      this.textButton,
      this.textState,
      this.function})
      : super(key: key);
  @override
  _EmptyState createState() => _EmptyState();
}

class _EmptyState extends State<Empty> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: EmptyWidget(
            image: null,
            packageImage: widget.image,
            title: widget.title,
            subTitle: widget.subtitle,
            hideBackgroundAnimation: true,
            titleTextStyle: TextStyle(
              fontSize: 22,
              color: Color(0xFFCC39191),
              fontWeight: FontWeight.w500,
            ),
            subtitleTextStyle: TextStyle(
              fontSize: 14,
              color: Color(0xFFCC39191),
            ),
          ),
        ),
        widget.button
            ? Center(
                child: ElevatedButton(
                  child: Text(widget.textButton),
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFFCC39191),
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    padding: EdgeInsets.all(15),
                  ),
                  onPressed: () {
                    widget.function();
                  },
                ),
              )
            : Text(''),
      ],
    );
  }
}
