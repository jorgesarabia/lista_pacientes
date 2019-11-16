import 'package:flutter/widgets.dart';

class UsersModel {
  final String uid;
  final String email;
  String nombre;
  int limite;

  UsersModel({
    Key key,
    @required this.uid,
    @required this.email,
    this.nombre,
    this.limite
  });

  @override
  String toString(){
    return '''
    {
      uid: $uid,
      email: $email,
      nombre: $nombre,
      limite: $limite,
    }
    ''';
  }
}
