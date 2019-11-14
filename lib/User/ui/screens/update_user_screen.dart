import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lista_pacientes/User/bloc/bloc.dart';
import 'package:lista_pacientes/User/ui/widgets/update_name_form.dart';
import 'package:lista_pacientes/widgets/my_divider.dart';

class UpdateUserScreen extends StatefulWidget {
  @override
  _UpdateUserScreenState createState() => _UpdateUserScreenState();
}

class _UpdateUserScreenState extends State<UpdateUserScreen> {
  double screenWidth;

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
                  child: UpdateNameForm(),
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
                        "Un nombre de clinica exageradamente largo, tambien innecesariamente largo",
                        style: TextStyle(
                          fontFamily: "Lato",
                          fontSize: 17.0,
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
        MyDivider(dividerTitle: "Editar otros atributos"),
        SizedBox(height: 15.0),
        GestureDetector(
          onTap: () {
            print("Se va editar");
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
                        "Editar Password",
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
