import 'package:flutter/material.dart';
import 'package:lista_pacientes/Pacientes/model/pacientes_model.dart';

class DetailScreen extends StatelessWidget {
  final PacientesModel pacientesModel;

  DetailScreen({
    Key key,
    @required this.pacientesModel,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("${pacientesModel.nombre}")),
      body: detallePaciente(),
    );
  }

  Widget detallePaciente() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '${pacientesModel.nombre}',
              style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
