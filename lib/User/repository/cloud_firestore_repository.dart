import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lista_pacientes/User/model/users_model.dart';
import 'package:lista_pacientes/common/singletons.dart';

class CloudFirestoreRepository {
  static const String USERS = "users";
  Singletons _singletons = Singletons();

  final Firestore _db = Firestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> updatePassword(String actualPassword, String newPassword) async {
    UsersModel usersModel = _singletons.getUser();
    print("======================");
    print("Antes de cambiar el password se reautentica");
    print("======================");
    FirebaseUser user = await _auth
        .signInWithEmailAndPassword(
      email: usersModel.email,
      password: actualPassword,
    ).catchError((error) {
      print("=============");
      print("Usuario No Autenticado");
      print(error.toString());
      print(error.code);
      print("=============");
      throw error;
    });
    print("======================");
    print("Se quiere cambiar el password");
    print("======================");
    await user.updatePassword(newPassword).catchError((onError) {
      print(onError.toString());
    });
  }

  Future<void> updateUserData(UsersModel user) async {
    print("Se actualiza o se crea el usuario");
    DocumentReference ref = _db.collection(USERS).document(user.uid);
    await ref.get().then((DocumentSnapshot s) {
      if (s.exists) {
        ref.updateData({
          "lastSignIn": DateTime.now(),
        });
        user.nombre = s.data["nombre"];
        user.limite = s.data["limite"];
      } else {
        ref.setData({
          "uid": user.uid,
          "nombre": user.nombre,
          "email": user.email,
          "limite": 5,
          "lastSignIn": DateTime.now(),
        }, merge: true);
      }
      _updateSingleton(UsersModel(
        uid: user.uid,
        nombre: user.nombre,
        email: user.email,
        limite: user.limite,
      ));
    });
  }

  Future<void> updateUserNames(String nombre) async {
    UsersModel usersModel = _singletons.getUser();
    DocumentReference ref = _db.collection(USERS).document(usersModel.uid);
    await ref.get().then((DocumentSnapshot s) {
      if (s.exists) {
        print("Se actualiza el nombre.");
        ref.updateData({
          "nombre": nombre,
          "lastSignIn": DateTime.now(),
        }).then((_) {
          _updateSingleton(UsersModel(
            email: s.data["email"],
            nombre: nombre,
            uid: s.data["uid"],
            limite: s.data["limite"],
          ));
        });
      }
    });
  }

  Future<void> getUserData(UsersModel user) async {
    DocumentReference ref = _db.collection(USERS).document(user.uid);
    await ref.get().then((DocumentSnapshot s) {
      if (s.exists) {
        print(s.data);
        _updateSingleton(UsersModel(
          email: s.data["email"],
          nombre: s.data["nombre"],
          uid: s.data["uid"],
          limite: s.data["limite"],
        ));
      }
    });
  }

  void _updateSingleton(UsersModel userModel) {
    print("Actualizamos el singleton");
    _singletons.setUser(userModel);
  }
}
