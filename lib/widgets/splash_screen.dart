import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.lightBlue),
      child: Center(
        child: SizedBox(
          width: 100.0,
          height: 100.0,
          child: CircularProgressIndicator(
            backgroundColor: Colors.red,
            valueColor: AlwaysStoppedAnimation(Colors.blue),
            strokeWidth: 10.0,
          ),
        ),
      ),
    );
  }
}
