import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lista_pacientes/Login/bloc/bloc.dart';
import 'package:lista_pacientes/Login/ui/widgets/login_form.dart';
import 'package:lista_pacientes/User/repository/auth_repository.dart';

class LoginScreen extends StatelessWidget {
  final AuthRepository _authRepository;

  LoginScreen({Key key, @required AuthRepository authRepository})
      : assert(authRepository != null),
        _authRepository = authRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<LoginBloc>(
        builder: (context) => LoginBloc(authRepository: _authRepository),
        child: LoginForm(authRepository: _authRepository),
      ),
    );
  }
}
