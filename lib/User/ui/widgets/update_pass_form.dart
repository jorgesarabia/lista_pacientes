import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lista_pacientes/User/bloc/bloc.dart';
import 'package:lista_pacientes/User/model/users_model.dart';
import 'package:lista_pacientes/common/singletons.dart';
import 'package:lista_pacientes/widgets/generic_button.dart';

class UpdatePassForm extends StatefulWidget {
  @override
  _UpdatePassFormState createState() => _UpdatePassFormState();
}

class _UpdatePassFormState extends State<UpdatePassForm> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _rePasswordController = TextEditingController();

  String _title = "Crear";
  String _messageBox = "Creando Paciente ...";
  String _messageError = "Error al Crear Paciente ..";

  Singletons _singletons = Singletons();
  UsersModel usersModel;

  UserBloc _userBloc;

  bool get _isButtonEnabled => _passwordController.text.isNotEmpty;

  @override
  void initState() {
    super.initState();
    _userBloc = BlocProvider.of<UserBloc>(context);
    usersModel = _singletons.getUser();
    _passwordController.addListener(_onPasswordChanged);
    print("======================================================");
    print("User Model: ${usersModel.toString()}");
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
            child: myForm(state),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _rePasswordController.dispose();
    super.dispose();
  }

  Widget myForm(state) {
    return Form(
      child: ListView(
        children: <Widget>[
          TextFormField(
            controller: _passwordController,
            decoration: InputDecoration(
              icon: Icon(Icons.lock),
              labelText: 'Password',
            ),
            obscureText: true,
            autovalidate: true,
            autocorrect: false,
            validator: (_) {
              return !state.isPasswordValid ? 'Password inválido' : null;
            },
          ),
          TextFormField(
            controller: _rePasswordController,
            decoration: InputDecoration(
              icon: Icon(Icons.lock),
              labelText: 'Password de nuevo',
            ),
            obscureText: true,
            autovalidate: true,
            autocorrect: false,
            validator: (_) {
              return !state.isPasswordValid ? 'Password no coincide' : null;
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

  void _onPasswordChanged() {
    _userBloc.add(
      PassChanged(password: _passwordController.text),
    );
  }

  void _onFormSubmitted() {
    print("Se manda al server");
  }
}

