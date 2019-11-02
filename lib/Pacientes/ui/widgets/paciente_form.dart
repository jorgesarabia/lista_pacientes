import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lista_pacientes/Pacientes/bloc/bloc.dart';
import 'package:lista_pacientes/Pacientes/model/pacientes_model.dart';
import 'package:lista_pacientes/widgets/generic_button.dart';

class PacienteForm extends StatefulWidget {
  final PacientesModel pacientesModel;

  PacienteForm({
    Key key,
    this.pacientesModel,
  });

  @override
  _PacienteFormState createState() => _PacienteFormState();
}

class _PacienteFormState extends State<PacienteForm> {
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _ciController = TextEditingController();
  final TextEditingController _nroLibretaController = TextEditingController();

  PacientesBloc _pacientesBloc;

  @override
  void initState() {
    super.initState();
    _pacientesBloc = BlocProvider.of<PacientesBloc>(context);
    _nombreController.addListener(_onNombreChanged);
    _ciController.addListener(_onCiChanged);
    _nroLibretaController.addListener(_onNroLibretaChanged);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PacientesBloc, PacientesState>(
      listener: (context, state) {
        if (state.isFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Error al crear el paciente'),
                    Icon(Icons.error)
                  ],
                ),
                backgroundColor: Colors.red,
              ),
            );
        }
        if (state.isSubmitting) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Creando Paciente ..."),
                    CircularProgressIndicator(),
                  ],
                ),
              ),
            );
        }
        if (state.isSuccess) {
          Navigator.pop(context);
        }
      },
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
              icon: Icon(Icons.person),
              labelText: 'Nombre Paciente',
            ),
            autovalidate: true,
            autocorrect: false,
            validator: (_) {
              return !state.isNameValid ? 'Campo Requerido' : null;
            },
          ),
          TextFormField(
            controller: _ciController,
            decoration: InputDecoration(
              icon: Icon(Icons.credit_card),
              labelText: 'C.I.',
            ),
            autovalidate: true,
            autocorrect: false,
            validator: (_) {
              return !state.isCiValid ? 'Campo Requerido' : null;
            },
          ),
          TextFormField(
            controller: _nroLibretaController,
            decoration: InputDecoration(
              icon: Icon(Icons.library_books),
              labelText: 'Libreta Nro.',
            ),
            autovalidate: true,
            autocorrect: false,
            validator: (_) {
              return !state.isNroLibretaValid ? 'Campo Requerido' : null;
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

  bool get isPopulated =>
      _nombreController.text.isNotEmpty &&
      _ciController.text.isNotEmpty &&
      _nroLibretaController.text.isNotEmpty;

  bool isButtonEnabled(PacientesState state) {
    return isPopulated && !state.isSubmitting && state.isFormValid;
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _ciController.dispose();
    _nroLibretaController.dispose();
    super.dispose();
  }

  //Se agrega este evento cuando cambia el nombre:
  void _onNombreChanged() {
    _pacientesBloc.add(
      NombreChanged(nombre: _nombreController.text),
    );
  }

  void _onCiChanged() {
    _pacientesBloc.add(
      CIChanged(ci: _ciController.text),
    );
  }

  void _onNroLibretaChanged() {
    _pacientesBloc.add(
      NroLibretaChanged(nroLibreta: _nroLibretaController.text),
    );
  }

  void _onFormSubmitted() {
    _pacientesBloc.add(
      CrearNuevoPaciente(
        nombre: _nombreController.text,
        nroLibreta: _nroLibretaController.text,
        ci: _ciController.text,
      ),
    );
  }
}
