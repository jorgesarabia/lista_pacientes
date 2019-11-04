import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lista_pacientes/Pacientes/ui/screens/list_screen.dart';
import 'package:lista_pacientes/User/model/users_model.dart';
import 'package:lista_pacientes/User/ui/screens/update_user_screen.dart';
import 'package:lista_pacientes/common/authentication_bloc/bloc.dart';
import 'package:lista_pacientes/common/singletons.dart';

enum WhyFarther { harder, smarter, selfStarter, tradingCharter }

class HomeScreen extends StatelessWidget {
  Choice _selectedChoice = choices[0]; // The app's "state".

  void _select(Choice choice) {
    // Causes the app to rebuild with the new _selectedChoice.
    // setState(() {
    // _selectedChoice = choice;
    // });
  }
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
          ),
          PopupMenuButton<Choice>(
            onSelected: _select,
            itemBuilder: (BuildContext context) {
              return choices.skip(2).map((Choice choice) {
                return PopupMenuItem<Choice>(
                  value: choice,
                  child: Text(choice.title),
                );
              }).toList();
            },
          ),
          PopupMenuButton<WhyFarther>(
            onSelected: (WhyFarther result) {return _select;},
            itemBuilder: (BuildContext context) {
              List<PopupMenuEntry<WhyFarther>> lista = [
                PopupMenuItem(
                 value: WhyFarther.harder,
                 child: Row(children: <Widget>[Icon(Icons.ac_unit), SizedBox(width: 15.0,), Text("Algo")]),
                ),
              ];
              return lista;
            },
          ),
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

class Choice {
  const Choice({this.title, this.icon});

  final String title;
  final IconData icon;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: 'Car', icon: Icons.directions_car),
  const Choice(title: 'Bicycle', icon: Icons.directions_bike),
  const Choice(title: 'Boat', icon: Icons.directions_boat),
  const Choice(title: 'Bus', icon: Icons.directions_bus),
  const Choice(title: 'Train', icon: Icons.directions_railway),
  const Choice(title: 'Walk', icon: Icons.directions_walk),
];

class ChoiceCard extends StatelessWidget {
  const ChoiceCard({Key key, this.choice}) : super(key: key);

  final Choice choice;

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = Theme.of(context).textTheme.display1;
    return Card(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(choice.icon, size: 128.0, color: textStyle.color),
            Text(choice.title, style: textStyle),
          ],
        ),
      ),
    );
  }
}
