import 'package:flutter/material.dart';
import 'package:lista_pacientes/User/repository/auth_repository.dart';
import 'package:lista_pacientes/User/repository/cloud_firestore_repository.dart';
import 'package:lista_pacientes/User/ui/widgets/update_user_button.dart';
import 'package:lista_pacientes/common/singletons.dart';

class UpdateUserForm extends StatefulWidget {
  @override
  _UpdateUserFormState createState() => _UpdateUserFormState();
}

class _UpdateUserFormState extends State<UpdateUserForm> {
  final TextEditingController _emailController = TextEditingController();
  bool _hasError = false;
  CloudFirestoreRepository _repository = CloudFirestoreRepository();
  Singletons _singletons = Singletons();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Form(
        child: ListView(
          children: <Widget>[
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                icon: Icon(Icons.account_balance),
                labelText: "Nombre",
              ),
              autovalidate: _hasError,
              autocorrect: false,
              validator: _validate,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  UpdateUserButton(
                    onPressed: () {
                      if (!_hasError) {
                        print("Se tiene que actualizar");
                        print("El valor es ${_emailController.text}");
                        String uid = _singletons.getUser().uid;
                        String nombre = _emailController.text;
                        _repository.updateUserName(uid, nombre);
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
    _emailController.dispose();
    super.dispose();
  }

  String _validate(String value) {
    _hasError = false;
    if (value.isEmpty) {
      _hasError = true;
      return "Campo Requerido";
    }
    return null;
  }
}
