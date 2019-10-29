import 'package:firebase_auth/firebase_auth.dart';
import 'package:lista_pacientes/User/model/users_model.dart';
import 'package:lista_pacientes/common/singletons.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth;
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

  Future<bool> isSignedIn() async {
    final currentUser = await _firebaseAuth.currentUser();
    return currentUser != null;
  }

  Future<String> getUser() async {
    var user = await _firebaseAuth.currentUser();
    _singletons.setUsersModel( UsersModel(
      email: user.email,
      uid: user.uid,
    ));
    return user.email;
  }
}
