import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lista_pacientes/Pacientes/find_bloc/bloc.dart';
import 'package:lista_pacientes/Pacientes/ui/widgets/pacientes_lista.dart';

class ListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Lista de pacientes")),
      body: BlocProvider<FindBloc>(
        builder: (context) => FindBloc(),
        child: PacientesLista(),
      ),
    );
  }
}
