import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lista_pacientes/Pacientes/bloc/bloc.dart';
import 'package:lista_pacientes/Pacientes/model/pacientes_model.dart';
import 'package:lista_pacientes/Pacientes/ui/widgets/paciente_form.dart';

class FormScreen extends StatelessWidget {
  final PacientesModel pacientesModel;
  FormScreen(this.pacientesModel);
  @override
  Widget build(BuildContext context) {
    String title = "Agregar Paciente";
    if (pacientesModel != null) title = "Actualizar Paciente";

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: BlocProvider<PacientesBloc>(
        builder: (context) => PacientesBloc(),
        child: PacienteForm(pacientesModel: pacientesModel),
      ),
    );
  }
}
