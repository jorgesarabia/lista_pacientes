import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lista_pacientes/User/model/users_model.dart';
import 'package:lista_pacientes/User/repository/cloud_firestore_repository.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth;
  final CloudFirestoreRepository _cloudFire = CloudFirestoreRepository();
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  AuthRepository({FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  Future<void> signInWithCredentials(String email, String password) {
    return _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<FirebaseUser> signInWithGoogle() async {
    await _googleSignIn.signOut();//Por un errror de que se queda guardado
    GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication gSA = await googleSignInAccount.authentication;

    FirebaseUser user = await _firebaseAuth.signInWithCredential(
      GoogleAuthProvider.getCredential(
        idToken: gSA.idToken,
        accessToken: gSA.accessToken,
      ),
    );

    return user;
  }

  Future<void> signOut() async {
    return Future.wait([
      _firebaseAuth.signOut(),
      _googleSignIn.signOut(),
    ]);
  }

  Future<FirebaseUser> getUser() async {
    final user = await _firebaseAuth.currentUser();
    await updateUser(user);
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
