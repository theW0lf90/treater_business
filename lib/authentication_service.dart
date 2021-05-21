import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;

//  final fb = FacebookAuth.instance;

  AuthenticationService(this._firebaseAuth);

  Stream<User> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<String> signIn({String email, String password}) async {
    try {
      _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return "Signed in";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<void> logOut() async {
    _firebaseAuth.signOut();
  }

  Future<bool> registerNewUser({String email, String password}) async {
    final User user = (await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password))
        .user;
    if (user != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<String> signUp({String email, String password}) async {
    try {
      _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return "Created";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future createUser({String email, String password}) async {
    try {
      User user = (await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password))
          .user;
      // if(user !=null) {
      //   /*TO DO
      //   - save meta data
      //   */

      // }
      // return user;
      return user;
    } on FirebaseAuthException catch (e) {
      print(e.message);
      //  return e.message;
    }
  }
}
