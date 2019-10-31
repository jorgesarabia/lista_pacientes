import 'package:flutter/material.dart';
import 'package:lista_pacientes/Pacientes/ui/screens/new_screen.dart';
import 'package:lista_pacientes/Pacientes/ui/widgets/paciente_card.dart';

class PacientesListScreen extends StatefulWidget {
  @override
  _PacientesListScreenState createState() => _PacientesListScreenState();
}

class _PacientesListScreenState extends State<PacientesListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de pacientes"),
      ),
      body: ListView(
        children: <Widget>[
          listaDePacientes(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("Se debe cargar un nuevo Paciente");
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => NewPacienteScreen()),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }

  Widget listaDePacientes() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        PacienteCard(
          name: "Jorge Sarabia",
          details: "CI: 5.555.555",
          comment: "Lib. nro: 100",
        ),
        PacienteCard(
          name: "Jorge Sarabia",
          details: "CI: 5.555.555",
          comment: "Lib. nro: 100",
        ),
        PacienteCard(
          name: "Jorge Sarabia",
          details: "CI: 5.555.555",
          comment: "Lib. nro: 100",
        ),
        PacienteCard(
          name: "Jorge Sarabia",
          details: "CI: 5.555.555",
          comment: "Lib. nro: 100",
        ),
        PacienteCard(
          name: "Jorge Sarabia",
          details: "CI: 5.555.555",
          comment: "Lib. nro: 100",
        ),
        PacienteCard(
          name: "Jorge Sarabia",
          details: "CI: 5.555.555",
          comment: "Lib. nro: 100",
        ),
        PacienteCard(
          name: "Jorge Sarabia",
          details: "CI: 5.555.555",
          comment: "Lib. nro: 100",
        ),
        PacienteCard(
          name: "Jorge Sarabia",
          details: "CI: 5.555.555",
          comment: "Lib. nro: 100",
        ),
        PacienteCard(
          name: "Jorge Sarabia",
          details: "CI: 5.555.555",
          comment: "Lib. nro: 100",
        ),
        PacienteCard(
          name: "Jorge Sarabia",
          details: "CI: 5.555.555",
          comment: "Lib. nro: 100",
        ),
        PacienteCard(
          name: "Jorge Sarabia",
          details: "CI: 5.555.555",
          comment: "Lib. nro: 100",
        ),
        PacienteCard(
          name: "Jorge Sarabia",
          details: "CI: 5.555.555",
          comment: "Lib. nro: 100",
        ),
        PacienteCard(
          name: "Jorge Sarabia",
          details: "CI: 5.555.555",
          comment: "Lib. nro: 100",
        ),
        PacienteCard(
          name: "Jorge Sarabia",
          details: "CI: 5.555.555",
          comment: "Lib. nro: 100",
        ),
        PacienteCard(
          name: "Jorge Sarabia",
          details: "CI: 5.555.555",
          comment: "Lib. nro: 100",
        ),
      ],
    );
  }
}
