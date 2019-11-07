import 'package:flutter/material.dart';

class ItemDetail extends StatelessWidget {
  final IconData icon;
  final String detail;

  ItemDetail({
    Key key,
    @required this.icon,
    @required this.detail,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        SizedBox(width: 30.0),
        Icon(
          icon,
          size: 35.0,
          color: Colors.lightBlue,
        ),
        SizedBox(width: 10.0),
        Flexible(
          child: Text(
            detail,
            style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
