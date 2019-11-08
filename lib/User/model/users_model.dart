import 'package:flutter/widgets.dart';

class UsersModel {
  final String uid;
  final String email;
  String nombre;

  UsersModel({
    Key key,
    @required this.uid,
    @required this.email,
    this.nombre,
  });

  @override
  String toString(){
    return '''
    {
      uid: $uid,
      email: $email,
      nombre: $nombre,
    }
    ''';
  }
}
