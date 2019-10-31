import 'package:flutter/material.dart';
import 'package:lista_pacientes/Pacientes/model/pacientes_model.dart';

class PacienteCard extends StatelessWidget {
  final PacientesModel pacientesModel;

  PacienteCard({
    Key key,
    @required this.pacientesModel,
  });

  @override
  Widget build(BuildContext context) {
    final _pacienteLibreta = Container(
      margin: EdgeInsets.only(left: 20.0),
      child: Text(
        "Libreta nro: ${pacientesModel.nroLibreta}",
        textAlign: TextAlign.left,
        style: TextStyle(
          fontFamily: "Lato",
          fontSize: 13.0,
          fontWeight: FontWeight.w900,
        ),
      ),
    );

    final _pacienteCI = Container(
      margin: EdgeInsets.only(left: 20.0),
      child: Text(
        "CI: ${pacientesModel.ci}",
        textAlign: TextAlign.left,
        style: TextStyle(
          fontFamily: "Lato",
          fontSize: 13.0,
          color: Color(0xFFa3a5a7),
        ),
      ),
    );

    final _pacienteNombre = Container(
      margin: EdgeInsets.only(left: 20.0),
      child: Text(
        "${pacientesModel.nombre}",
        textAlign: TextAlign.left,
        style: TextStyle(
          fontFamily: "Lato",
          fontSize: 17.0,
        ),
      ),
    );

    final userDetails = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _pacienteNombre,
        _pacienteCI,
        _pacienteLibreta,
      ],
    );

    final photo = Container(
      margin: EdgeInsets.only(top: 20.0, left: 20.0),
      width: 80.0,
      height: 80.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage("assets/flutter_logo.png"),
        ),
      ),
    );

    return Row(
      children: <Widget>[
        photo,
        userDetails,
      ],
    );
  }
}
