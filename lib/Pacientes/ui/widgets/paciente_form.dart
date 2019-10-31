import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lista_pacientes/Pacientes/bloc/bloc.dart';
import 'package:lista_pacientes/widgets/generic_button.dart';

class PacienteForm extends StatefulWidget {
  @override
  _PacienteFormState createState() => _PacienteFormState();
}

class _PacienteFormState extends State<PacienteForm> {
  final TextEditingController _nombreController = TextEditingController();

  PacientesBloc _pacientesBloc;

  @override
  void initState() {
    super.initState();
    _pacientesBloc = BlocProvider.of<PacientesBloc>(context);
    _nombreController.addListener(_onNombreChanged);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PacientesBloc, PacientesState>(
      listener: (context, state) {},
      child: BlocBuilder<PacientesBloc, PacientesState>(
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.all(20.0),
            child: myForm(state),
          );
        },
      ),
    );
  }

  Widget myForm(state) {
    return Form(
      child: ListView(
        children: <Widget>[
          TextFormField(
            controller: _nombreController,
            decoration: InputDecoration(
              icon: Icon(Icons.text_fields),
              labelText: 'Nombre',
            ),
            autovalidate: true,
            autocorrect: false,
            validator: (_) {
              return !state.isNameValid ? '' : null;
            },
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                GenericButton(
                  title: "Crear",
                  onPressed: isButtonEnabled(state) ? _onFormSubmitted : null,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  bool get isPopulated => _nombreController.text.isNotEmpty;

  bool isButtonEnabled(PacientesState state) {
    return isPopulated;
  }

  @override
  void dispose() {
    _nombreController.dispose();
    super.dispose();
  }

  //Se agrega este evento cuando cambia el nombre:
  void _onNombreChanged() {
    _pacientesBloc.add(
      NombreChanged(nombre: _nombreController.text),
    );
  }

  void _onFormSubmitted() {
    _pacientesBloc.add(
      CrearNuevoPaciente(
        nombre: _nombreController.text,
        nroLibreta: "100",
      ),
    );
  }
}
