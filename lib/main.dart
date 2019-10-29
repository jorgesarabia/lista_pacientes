import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:lista_pacientes/Home/ui/screens/home_screen.dart';
import 'package:lista_pacientes/Login/ui/screens/login_screen.dart';
import 'package:lista_pacientes/User/repository/auth_repository.dart';
import 'package:lista_pacientes/common/authentication_bloc/bloc.dart';
import 'package:lista_pacientes/common/simple_bloc_delegate.dart';
import 'package:lista_pacientes/common/singletons.dart';
import 'package:lista_pacientes/widgets/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  BlocSupervisor.delegate = SimpleBlocDelegate();
  final AuthRepository authRepository = AuthRepository();
  runApp(
    BlocProvider(
      builder: (context) =>
          AuthenticationBloc(userRepository: authRepository)..add(AppStarted()),
      child: App(authRepository: authRepository),
    ),
  );
}

class App extends StatelessWidget {
  final AuthRepository _authRepository;
  final Singletons _singletons = Singletons();

  App({Key key, @required AuthRepository authRepository})
      : assert(authRepository != null),
        _authRepository = authRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is Uninitialized) {
            return SplashScreen();
          }
          if (state is Unauthenticated) {
            return LoginScreen(authRepository: _authRepository);
          }
          if (state is Authenticated) {
            return HomeScreen(name: _singletons.getUsersModel().email);
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}
