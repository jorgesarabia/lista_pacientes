import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lista_pacientes/Pacientes/find_bloc/bloc.dart';
import 'package:lista_pacientes/Pacientes/ui/widgets/pacientes_lista.dart';
import 'package:lista_pacientes/User/ui/screens/update_user_screen.dart';
import 'package:lista_pacientes/common/authentication_bloc/bloc.dart';

enum MenuOptions { editProfile, logOut }

class ListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de pacientes"),
        actions: <Widget>[
          PopupMenuButton<MenuOptions>(
            onSelected: (MenuOptions result) => _myActions(result, context),
            itemBuilder: (BuildContext context) {
              List<PopupMenuEntry<MenuOptions>> lista = [
                PopupMenuItem(
                  value: MenuOptions.editProfile,
                  child: Row(children: <Widget>[
                    Icon(Icons.settings),
                    SizedBox(
                      width: 15.0,
                    ),
                    Text("Configuración"),
                  ]),
                ),
                PopupMenuItem(
                  value: MenuOptions.logOut,
                  child: Row(children: <Widget>[
                    Icon(Icons.exit_to_app),
                    SizedBox(
                      width: 15.0,
                    ),
                    Text("Salir"),
                  ]),
                ),
              ];
              return lista;
            },
          ),
        ],
      ),
      body: BlocProvider<FindBloc>(
        builder: (context) => FindBloc(),
        child: PacientesLista(),
      ),
    );
  }

  void _myActions(MenuOptions result, BuildContext context) {
    switch (result) {
      case MenuOptions.editProfile:
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => UpdateUserScreen()),
        );
        break;
      case MenuOptions.logOut:
        _signOut(context);
        break;
      default:
        print("Esto no debería suceder");
    }
  }

  Future<void> _signOut(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Salir'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('¿Desea cerrar la sesión?.'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Si'),
              onPressed: () {
                BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
