import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lista_pacientes/User/bloc/bloc.dart';
import 'package:lista_pacientes/User/model/users_model.dart';
import 'package:lista_pacientes/User/ui/widgets/update_name_form.dart';
import 'package:lista_pacientes/User/ui/widgets/update_pass_form.dart';
import 'package:lista_pacientes/common/singletons.dart';
import 'package:lista_pacientes/widgets/my_divider.dart';

class UpdateUserScreen extends StatefulWidget {
  @override
  _UpdateUserScreenState createState() => _UpdateUserScreenState();
}

class _UpdateUserScreenState extends State<UpdateUserScreen> {
  double screenWidth;
  final Singletons _singletons = Singletons();
  UsersModel usersModel;

  @override
  void initState() {
    super.initState();
    usersModel = _singletons.getUser();
    print("======================================================");
    print("User Model: ${usersModel.toString()}");
    print("======================================================");
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    print("================");
    print("El ancho es $screenWidth");
    print("================");

    return Scaffold(
      appBar: AppBar(
        title: Text("Actualizar Datos"),
      ),
      body: updateScreen(),
      // body: BlocProvider<UserBloc>(
      // builder: (context) => UserBloc(),
      // child: UpdateUserForm(),
      // ),
    );
  }

  Widget updateScreen() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(height: 20.0),
        MyDivider(dividerTitle: "Editar Nombre de la Organización"),
        SizedBox(height: 15.0),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => BlocProvider<UserBloc>(
                  builder: (context) => UserBloc(),
                  child: Scaffold(
                    appBar: AppBar(
                      title: Text("Actualizar Nombre"),
                    ),
                    body: UpdateNameForm(),
                  ),
                ),
              ),
            );
          },
          child: Card(
            elevation: 5,
            child: SizedBox(
              child: Padding(
                padding: EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Flexible(
                      child: Text(
                        "${usersModel.nombre}",
                        style: TextStyle(
                          fontFamily: "Lato",
                          fontSize: 17.0,
                          color: Colors.black38,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 25.0),
        MyDivider(dividerTitle: "Editar Password"),
        SizedBox(height: 15.0),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => BlocProvider<UserBloc>(
                  builder: (context) => UserBloc(),
                  child: Scaffold(
                    appBar: AppBar(
                      title: Text("Cambiar Password"),
                    ),
                    body: UpdatePassForm(),
                  ),
                ),
              ),
            );
          },
          child: Card(
            elevation: 5,
            child: SizedBox(
              child: Padding(
                padding: EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Flexible(
                      child: Text(
                        "**********",
                        style: TextStyle(
                          fontFamily: "Lato",
                          fontSize: 17.0,
                          color: Colors.black38,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
