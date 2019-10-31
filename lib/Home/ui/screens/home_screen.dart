import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lista_pacientes/Pacientes/ui/screens/list_screen.dart';
import 'package:lista_pacientes/User/model/users_model.dart';
import 'package:lista_pacientes/User/ui/screens/update_user_screen.dart';
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
        children: <Widget>[
          Text('Welcome $nombre!'),
          FlatButton(
            child: Text("Editar Usuario"),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => UpdateUserScreen()),
              );
            },
          ),
          FlatButton(
            child: Text("Ver Listas"),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => ListScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
