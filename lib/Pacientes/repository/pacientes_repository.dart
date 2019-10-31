import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lista_pacientes/Pacientes/model/pacientes_model.dart';
import 'package:lista_pacientes/User/model/users_model.dart';
import 'package:lista_pacientes/common/singletons.dart';

class PacientesRepository {
  static const String PACIENTES = "pacientes";
  Singletons _singletons = Singletons();

  final Firestore _db = Firestore.instance;

  Future<void> updateOrCreate(PacientesModel pacientesModel) async {
    UsersModel user = _singletons.getUser();
    DocumentReference ref = _db.collection("$PACIENTES-${user.uid}").document(pacientesModel.id);
    print("Se va crear o actualizar con:");
    print(pacientesModel.toString());
    await ref.get().then((DocumentSnapshot s) {
      if (s.exists) {
        print("El dato ya existe, solo se actualiza.");
        return ref.updateData({
          "nombre": pacientesModel.nombre ?? s.data["nombre"],
          "ci": pacientesModel.ci ?? s.data["ci"],
          "nroLibreta": pacientesModel.nroLibreta ?? s.data["nroLibreta"],
        });
      } else {
        print("El dato no existe, se crea.");
        return ref.setData({
        "nombre": pacientesModel.nombre,
        "ci": pacientesModel.ci,
        "nroLibreta": pacientesModel.nroLibreta,
        "created_at": DateTime.now(),
        }, merge: true);
      }
    });
  }
}
