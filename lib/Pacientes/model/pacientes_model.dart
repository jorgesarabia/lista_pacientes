import 'package:flutter/foundation.dart';

class PacientesModel {
  final String nombre;
  final String ci;
  final String email;
  final int nroLibreta;

  PacientesModel({
    Key key,
    @required this.nombre,
    @required this.ci,
    @required this.email,
    @required this.nroLibreta,
  });
}