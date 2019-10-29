import 'package:lista_pacientes/User/model/users_model.dart';

class Singletons {
  UsersModel _user;

  static Singletons _instance = Singletons._internal();

  Singletons._internal();

  factory Singletons() {
    return _instance;
  }

  void setUsersModel(UsersModel usersModel) {
    this._user = usersModel;
  }

  UsersModel getUsersModel() => _user;
}
