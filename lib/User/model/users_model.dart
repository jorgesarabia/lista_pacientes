import 'package:flutter/widgets.dart';

class UsersModel {
  final String uid;
  final String email;
  String nombre;
  int limite;
  int nroPacientes;

  UsersModel({
    Key key,
    @required this.uid,
    @required this.email,
    this.nombre,
    this.limite,
    this.nroPacientes,
  });

  @override
  String toString(){
    return '''
    {
      uid: $uid,
      email: $email,
      nombre: $nombre,
      limite: $limite,
      nroPacientes: $nroPacientes,
    }
    ''';
  }
}
