import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lista_pacientes/User/bloc/bloc.dart';
import 'package:lista_pacientes/User/model/users_model.dart';
import 'package:lista_pacientes/common/singletons.dart';
import 'package:lista_pacientes/widgets/generic_button.dart';

class UpdateNameForm extends StatefulWidget {
  @override
  _UpdateNameFormState createState() => _UpdateNameFormState();
}

class _UpdateNameFormState extends State<UpdateNameForm> {
  final TextEditingController _nombreController = TextEditingController();

  String _title = "Actualizar";
  String _messageBox = "Creando Paciente ...";
  String _messageError = "Error al Crear Paciente ..";

  Singletons _singletons = Singletons();
  UsersModel usersModel;

  UserBloc _userBloc;

  bool get _isButtonEnabled => _nombreController.text.isNotEmpty;

  @override
  void initState() {
    super.initState();
    _userBloc = BlocProvider.of<UserBloc>(context);
    usersModel = _singletons.getUser();
    _nombreController.text = usersModel.nombre;
    _nombreController.addListener(_onNombreChanged);
    print("======================================================");
    print("User Model: ${usersModel.toString()}");
    print("El nombre del usuario es: ${_nombreController.text}");
    print("======================================================");
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state.isFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text(_messageError), Icon(Icons.error)],
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
                    Text(_messageBox),
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
      child: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.all(20.0),
            child: Material(
              child: myForm(state),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _nombreController.dispose();
    super.dispose();
  }

  Widget myForm(state) {
    print("99");
    return Form(
      child: ListView(
        children: <Widget>[
          TextFormField(
            controller: _nombreController,
            decoration: InputDecoration(
              icon: Icon(Icons.store),
              labelText: 'Nombre de la Organización',
            ),
            autovalidate: true,
            autocorrect: false,
            validator: (_) {
              return !state.isNameValid ? 'Campo Requerido' : null;
            },
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                GenericButton(
                  title: _title,
                  onPressed: _isButtonEnabled ? _onFormSubmitted : null,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _onNombreChanged() {
    _userBloc.add(
      NombreChanged(nombre: _nombreController.text),
    );
  }

  void _onFormSubmitted() {
    _userBloc.add(
      UpdateUserName(
        nombre: _nombreController.text,
      ),
    );
  }
}
