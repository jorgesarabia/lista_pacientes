import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lista_pacientes/Pacientes/bloc/bloc.dart';
import 'package:lista_pacientes/Pacientes/ui/widgets/paciente_form.dart';

class NewPacienteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<PacientesBloc>(
        builder: (context) => PacientesBloc(),
        child: PacienteForm(),
      ),
    );
  }
}