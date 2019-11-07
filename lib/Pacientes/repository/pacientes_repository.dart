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
    DocumentReference ref =
        _db.collection("$PACIENTES-${user.uid}").document(pacientesModel.id);
    await ref.get().then((DocumentSnapshot s) {
      if (s.exists) {
        return ref.updateData({
          "nombre": pacientesModel.nombre ?? s.data["nombre"],
          "ci": pacientesModel.ci ?? s.data["ci"],
          "nroLibreta": pacientesModel.nroLibreta ?? s.data["nroLibreta"],
        });
      } else {
        return ref.setData({
          "nombre": pacientesModel.nombre,
          "ci": pacientesModel.ci,
          "nroLibreta": pacientesModel.nroLibreta,
          "created_at": DateTime.now(),
        }, merge: true);
      }
    });
  }

  Future<List<PacientesModel>> getPacientes() async {
    UsersModel user = _singletons.getUser();
    CollectionReference ref = _db.collection("$PACIENTES-${user.uid}");
    List<PacientesModel> list = [];
    await ref.getDocuments().then((QuerySnapshot querySnapshot) {
      querySnapshot.documents.forEach((f) {
        print(f.data["nombre"]);
        print(f.documentID);
        list.add(
          PacientesModel(
            id: f.documentID,
            ci: f.data["ci"],
            nombre: f.data["nombre"],
            nroLibreta: f.data["nroLibreta"],
          ),
        );
      });
    }).catchError((_) {
      print("=================");
      print("Hay un error");
      print("=================");
    });
    return list;
  }

}
