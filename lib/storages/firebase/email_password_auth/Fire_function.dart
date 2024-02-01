import 'package:firebase_auth/firebase_auth.dart';

class FirebaseHelper {
  final FirebaseAuth auth = FirebaseAuth.instance;/// creating object in globally

  get user => auth.currentUser;/// currently login ayittu ulla user inai kittan ayittu

//user SignUp
  Future<String?> registerUser({required String email, required String pwd}) async {
    try {
      await auth.createUserWithEmailAndPassword(
        email: email,
        password: pwd,
      );
       return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    } catch (e) {
      print(e);
    }
    return null;
  }

//signin user
  Future<String?> loginUser(
      {required String email, required String pwd}) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: pwd);
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
      return e.message;
    }
  }

  ///signOut
  Future<void> logout() async {
    await auth.signOut();
  }
}
