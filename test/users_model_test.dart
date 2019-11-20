import 'package:flutter_test/flutter_test.dart';
import 'package:lista_pacientes/User/model/users_model.dart';

void main() {
  UsersModel user = UsersModel(
    email: "algo@algo.com",
    uid: "22alsckanscl",
    limite: 4,
    nombre: "Juan Pistola",
    nroPacientes: 20,
  );

  group("toString()", () {
    test("should show all the fields", () {
      expect(user.toString(), equals('''
    {
      uid: 22alsckanscl,
      email: algo@algo.com,
      nombre: Juan Pistola,
      limite: 4,
      nroPacientes: 20,
    }
    '''));
    });
  });
}
