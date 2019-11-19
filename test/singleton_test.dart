import 'package:flutter_test/flutter_test.dart';
import 'package:lista_pacientes/User/model/users_model.dart';
import 'package:lista_pacientes/common/singletons.dart';

void main() {
  Singletons singletons = Singletons();
  UsersModel user = UsersModel(
    email: "algo@algo.com",
    uid: "22alsckanscl",
    limite: 4,
    nombre: "Juan Pistola",
    nroPacientes: 20,
  );

  group("Singleton validator", () {
    test("should be a singleton", () {
      Singletons x = Singletons();
      expect(singletons.hashCode, equals(x.hashCode));
    });

    test("should set an user and return user", () {
      expect(singletons.getUser(),equals(null));
      singletons.setUser(user);
      expect(singletons.getUser().hashCode,equals(user.hashCode));
    });
  });
}
