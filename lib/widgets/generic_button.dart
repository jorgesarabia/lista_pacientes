import 'package:flutter/material.dart';

class GenericButton extends StatelessWidget {
  final VoidCallback _onPressed;
  final String title;
  final Color color = Colors.lightBlue;

  GenericButton({
    Key key,
    VoidCallback onPressed,
    Color color,
    @required this.title,
  })  : _onPressed = onPressed,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      onPressed: _onPressed,
      child: Text(title),
      color: color ?? Colors.lightBlue,
    );
  }
}
