import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lista_pacientes/User/model/users_model.dart';
import 'package:lista_pacientes/common/authentication_bloc/bloc.dart';
import 'package:lista_pacientes/common/singletons.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Singletons singletons = Singletons();
    UsersModel user = singletons.getUser();
    String title;
    String nombre;
    if (user != null) {
      title = user.nombre;
      nombre = user.email;
    } else {
      title = "Home";
      nombre = "Email";
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
            },
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Center(child: Text('Welcome $nombre!')),
        ],
      ),
    );
  }
}
