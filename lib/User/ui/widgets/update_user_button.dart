import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class UpdateUserButton extends StatelessWidget {
  final VoidCallback _onPressed;

  UpdateUserButton({Key key, VoidCallback onPressed})
      : _onPressed = onPressed,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      onPressed: _onPressed,
      child: Text("Actualizar"),
    );
 }
}