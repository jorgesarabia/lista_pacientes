import 'package:flutter/material.dart';

class MyDivider extends StatelessWidget {
  final String dividerTitle;

  MyDivider({Key key, @required this.dividerTitle});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(child: Divider()),
        Text(
          dividerTitle,
          textAlign: TextAlign.left,
          style: TextStyle(
            fontFamily: "Lato",
            fontSize: 18.0,
            color: Color(0xFFa3a5a7),
          ),
        ),
        Expanded(child: Divider()),
      ],
    );
  }
}
