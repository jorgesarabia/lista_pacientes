import 'package:firebase_auth/firebase_auth.dart';
import 'package:lista_pacientes/User/model/users_model.dart';
import 'package:lista_pacientes/User/repository/cloud_firestore_repository.dart';
import 'package:lista_pacientes/common/singletons.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth;
  final CloudFirestoreRepository _cloudFire = CloudFirestoreRepository();
  Singletons _singletons = Singletons();

  AuthRepository({FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  Future<void> signInWithCredentials(String email, String password) {
    return _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signOut() async {
    return Future.wait([
      _firebaseAuth.signOut(),
    ]);
  }

  Future<FirebaseUser> getUser() async {
    final user = await _firebaseAuth.currentUser();
    return user;
  }

  updateUser(FirebaseUser user) async {
    UsersModel userFromFirebase = UsersModel(
      email: user.email,
      uid: user.uid,
    );
    await _cloudFire.updateUserData(userFromFirebase);
  }

}
