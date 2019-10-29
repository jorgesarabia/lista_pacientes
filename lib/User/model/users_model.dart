import 'package:flutter/widgets.dart';

class UsersModel {
  final String uid;
  final String email;
  final String name;
  final String ci;
  final int nroLibreta;

  UsersModel({
    Key key,
    @required this.uid,
    @required this.email,
    this.name,
    this.ci,
    this.nroLibreta,
  });
}
