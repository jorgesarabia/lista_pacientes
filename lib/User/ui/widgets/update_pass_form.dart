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
  final TextEditingController _passwordActual = TextEditingController();
  final TextEditingController _passwordNuevo = TextEditingController();
  final TextEditingController _reingresarPasswordNuevo =
      TextEditingController();

  String _title = "Actualizar";
  String _messageBox = "Actualizando Password...";

  Singletons _singletons = Singletons();
  UsersModel usersModel;

  UserBloc _userBloc;

  bool _isButtonEnabled(UserState state) {
    print(state.toString());
    return state.isActualPassValid &&
        state.isNewPassValid && _passwordActual.text.isNotEmpty &&
        _reingresarPasswordNuevo.text.isNotEmpty &&
        _reingresarPasswordNuevo.text == _passwordNuevo.text;
  }

  @override
  void initState() {
    super.initState();
    _userBloc = BlocProvider.of<UserBloc>(context);
    usersModel = _singletons.getUser();
    _passwordActual.addListener(_onActualPasswordChanged);
    _passwordNuevo.addListener(_onNewPasswordChanged);
    _reingresarPasswordNuevo.addListener(_onRetypeNewPasswordChanged);
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
                  children: [Text(state.errorMessage), Icon(Icons.error)],
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
            child: Material(child: myForm(state)),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _passwordActual.dispose();
    _passwordNuevo.dispose();
    _reingresarPasswordNuevo.dispose();
    super.dispose();
  }

  Widget myForm(UserState state) {
    return Form(
      child: ListView(
        children: <Widget>[
          TextFormField(
            controller: _passwordActual,
            decoration: InputDecoration(
              icon: Icon(Icons.lock),
              labelText: 'Password Actual',
            ),
            obscureText: true,
            autovalidate: true,
            autocorrect: false,
            validator: (_) {
              return !state.isActualPassValid
                  ? state.errorMessage
                  : null;
            },
          ),
          TextFormField(
            controller: _passwordNuevo,
            decoration: InputDecoration(
              icon: Icon(Icons.lock),
              labelText: 'Password Nuevo',
            ),
            obscureText: true,
            autovalidate: true,
            autocorrect: false,
            validator: (value) {
              String message = "";
              if (!state.isNewPassValid) {
                message += "Debe tener más de 6 caracteres ";
              }
              return message.length > 1 ? message : null;
            },
          ),
          TextFormField(
            controller: _reingresarPasswordNuevo,
            decoration: InputDecoration(
              icon: Icon(Icons.lock),
              labelText: 'Password Nuevo (reingresar)',
            ),
            obscureText: true,
            autovalidate: true,
            autocorrect: false,
            validator: (value) {
              return value != _passwordNuevo.text
                  ? "Passwords no coinciden"
                  : null;
            },
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                GenericButton(
                  title: _title,
                  onPressed: _isButtonEnabled(state) ? _onFormSubmitted : null,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _onActualPasswordChanged() {
    _userBloc.add(
      ActualPassChanged(password: _passwordActual.text),
    );
  }

  void _onNewPasswordChanged() {
    _userBloc.add(
      NewPassChanged(password: _passwordNuevo.text),
    );
  }

  void _onRetypeNewPasswordChanged() {
    _userBloc.add(
      RetypeNewPassChanged(password: _reingresarPasswordNuevo.text),
    );
  }

  void _onFormSubmitted() {
    print("Se manda al server");
    _userBloc.add(
      UpdatePassword(
        actualPassword: _passwordActual.text,
        newPassword: _passwordNuevo.text,
      ),
    );
  }
}
