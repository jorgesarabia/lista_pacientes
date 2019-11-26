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

    final userDetails = Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Flexible(
          child: Text(
            "${pacientesModel.nombre}",
            style: TextStyle(
              fontFamily: "Lato",
              fontSize: 17.0,
            ),
          ),
        ),
        SizedBox(height: 5.0),
        Flexible(
          child: Text(
            "CI: ${pacientesModel.ci}",
            textAlign: TextAlign.left,
            style: TextStyle(
              fontFamily: "Lato",
              fontSize: 13.0,
              color: Color(0xFFa3a5a7),
            ),
          ),
        ),
        SizedBox(height: 1.0),
        Flexible(
          child: Text(
            "Libreta nro: ${pacientesModel.nroLibreta}",
            textAlign: TextAlign.left,
            style: TextStyle(
              fontFamily: "Lato",
              fontSize: 13.0,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ],
    );

    final photo = Container(
      margin: EdgeInsets.only(top: 10.0, left: 10.0, bottom: 10.0),
      width: 80.0,
      height: 80.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage("assets/patient.webp"),
        ),
      ),
    );

    return Card(
      elevation: 3.0,
      child: Row(
        children: <Widget>[
          Flexible(
            child: photo,
          ),
          SizedBox(width: 15.0),
          Flexible(
            child: userDetails,
          ),
        ],
      ),
    );
  }
}
