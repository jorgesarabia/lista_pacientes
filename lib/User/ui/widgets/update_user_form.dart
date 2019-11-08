import 'package:flutter/material.dart';
import 'package:lista_pacientes/User/model/users_model.dart';
import 'package:lista_pacientes/User/repository/cloud_firestore_repository.dart';
import 'package:lista_pacientes/User/ui/widgets/update_user_button.dart';
import 'package:lista_pacientes/common/singletons.dart';

class UpdateUserForm extends StatefulWidget {
  @override
  _UpdateUserFormState createState() => _UpdateUserFormState();
}

class _UpdateUserFormState extends State<UpdateUserForm> {
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _rePasswordController = TextEditingController();
  bool _hasError = false;
  CloudFirestoreRepository _repository = CloudFirestoreRepository();
  Singletons _singletons = Singletons();
  UsersModel usersModel;

  @override
  void initState() {
    super.initState();
    usersModel = _singletons.getUser();
    _nombreController.text = usersModel.nombre;
    print("======================================================");
    print("User Model: ${usersModel.toString()}");
    print("El nombre del usuario es: ${_nombreController.text}");
    print("======================================================");
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Form(
        child: ListView(
          children: <Widget>[
            TextFormField(
              controller: _nombreController,
              decoration: InputDecoration(
                icon: Icon(Icons.account_balance),
                labelText: "Nombre",
              ),
              autovalidate: _hasError,
              autocorrect: false,
              validator: (value) => _validate(value, ""),
            ),
            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(
                icon: Icon(Icons.security),
                labelText: "Password",
              ),
              autovalidate: _hasError,
              autocorrect: false,
              validator: (value) => _validate(value, "pass"),
            ),
            TextFormField(
              controller: _rePasswordController,
              decoration: InputDecoration(
                icon: Icon(Icons.security),
                labelText: "Password de nuevo",
              ),
              autovalidate: _hasError,
              autocorrect: false,
              validator: (value) => _validate(value, "pass"),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  UpdateUserButton(
                    onPressed: () {
                      print("Se evalua el tema");
                      _validate(_nombreController.text, "");
                      _validate(_passwordController.text, "pass");
                      if (!_hasError) {
                        print("El valor es ${_nombreController.text}");
                        String uid = usersModel.uid;
                        String nombre = _nombreController.text;
                        // _repository.updateUserName(uid, nombre);
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _passwordController.dispose();
    _rePasswordController.dispose();
    super.dispose();
  }

  String _validate(String value, String from) {
    _hasError = true;
    if (value.isEmpty) {
      return "Campo Requerido";
    }
    if (from == "pass") {
      if (_passwordController.text.length < 7) {
        return "Debe tener más de 6 caracteres";
      }
      if (_passwordController.text != _rePasswordController.text) {
        return "Las contraseñas no coinciden";
      }
    }
    _hasError = false;
    return null;
  }
}
