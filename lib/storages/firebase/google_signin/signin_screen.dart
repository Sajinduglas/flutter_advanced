import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyDYrDyx_hirkEI9UR0xncX7JzzFasuoP_Q",
          appId: "1:119405132167:android:6c00ea5bb3b94db0e4fb22",
          messagingSenderId: " ",
          projectId: "fir-new-flutter-project",
          storageBucket: "fir-new-flutter-project.appspot.com"));
  User? user = FirebaseAuth.instance.currentUser;
  runApp(MaterialApp(
    home: SignInDemo(),
  ));
}

class SignInDemo extends StatefulWidget {
  @override
  State createState() => SignInDemoState();
}

class SignInDemoState extends State<SignInDemo> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<UserCredential?> _handleSignIn() async {
    try {
      GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
      GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;

      AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      return userCredential;
    } catch (error) {
      print(error);
      return null;
    }
  }

  void _navigateToHome(User? user) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomeScreen(user: user),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Sign-In Demo'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('Sign in with Google'),
          onPressed: () async {
            UserCredential? userCredential = await _handleSignIn();
            if (userCredential != null) {
              print(
                  'Successfully signed in with Google: ${userCredential.user!.displayName}');
              _navigateToHome(userCredential.user);
            } else {
              print('Google Sign-In failed');
            }
          },
        ),
      ),
    );
  }
}
