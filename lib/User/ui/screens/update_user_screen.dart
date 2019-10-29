import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lista_pacientes/User/ui/widgets/update_user_form.dart';

class UpdateUserScreen extends StatefulWidget{
  @override
  _UpdateUserScreenState createState() => _UpdateUserScreenState();
}

class _UpdateUserScreenState extends State<UpdateUserScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Actualizar nombre"),
      ),
      body: UpdateUserForm(),
    );
  }
}