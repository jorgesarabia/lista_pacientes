import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lista_pacientes/User/model/users_model.dart';
import 'package:lista_pacientes/common/singletons.dart';

class CloudFirestoreRepository {
  static const String USERS = "users";
  Singletons _singletons = Singletons();

  final Firestore _db = Firestore.instance;

  Future<void> updateUserData(UsersModel user) async {
    DocumentReference ref = _db.collection(USERS).document(user.uid);
    await ref.get().then((DocumentSnapshot s) {
      if (s.exists) {
        ref.updateData({
          "lastSignIn": DateTime.now(),
        });
      } else {
        ref.setData({
          "uid": user.uid,
          "nombre": user.nombre,
          "email": user.email,
          "lastSignIn": DateTime.now(),
        }, merge: true);
      }
      _updateSingleton(s);
    });
  }

  Future<void> updateUserName(String uid, String nombre) async {
    print("Se van a actualizar los datos");
    DocumentReference ref = _db.collection(USERS).document(uid);
    await ref.get().then((DocumentSnapshot s) {
      if (s.exists) {
        print("Se actualiza el nombre.");
        ref.updateData({
          "nombre": nombre,
          "lastSignIn": DateTime.now(),
        });
        _updateSingleton(s);
      }
    });
  }

  Future<void> getUserData(UsersModel user) async {
    DocumentReference ref = _db.collection(USERS).document(user.uid);
    await ref.get().then((DocumentSnapshot s) {
      if (s.exists) {
        print(s.data);
        _updateSingleton(s);
      }
    });
  }

  void _updateSingleton(DocumentSnapshot s) {
    print("Actualizamos el singleton");
    UsersModel userFromFirebase = UsersModel(
      email: s.data["email"],
      nombre: s.data["nombre"],
      uid: s.data["uid"],
    );

    _singletons.setUser(userFromFirebase);
  }
}
