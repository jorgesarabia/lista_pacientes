import 'package:flutter/foundation.dart';

class PacientesModel {
  String id;
  final String nombre;
  final String ci;
  final String nroLibreta;

  PacientesModel({
    Key key,
    this.id,
    @required this.nombre,
    @required this.ci,
    @required this.nroLibreta,
  });

  @override
  String toString() {
    return '''
    id: $id,
    nombre: $nombre,
    CI: $ci,
    nroLibreta: $nroLibreta,
    ''';
  }
}
