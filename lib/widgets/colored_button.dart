import 'package:flutter/material.dart';

class ColoredButton extends StatefulWidget {
  final String title;
  final VoidCallback onPressed;
  double height;
  double width;
  MaterialColor color;

  ColoredButton({
    Key key,
    @required this.title,
    @required this.onPressed,
    this.height,
    this.width,
    this.color,
  }){
    if(color == null){
      color = Colors.lightBlue;
    }
  }

  @override
  _ColoredButtonState createState() => _ColoredButtonState();
}

class _ColoredButtonState extends State<ColoredButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onPressed,
      child: Container(
        margin: EdgeInsets.only(top: 30.0, left: 20.0, right: 20.0),
        height: widget.height,
        width: widget.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            color: widget.color,
            ),
        child: Center(
          child: Text(
            widget.title,
            style: TextStyle(
                fontSize: 18.0, fontFamily: "Lato", color: Colors.white),
          ),
        ),
      ),
    );
  }
}
