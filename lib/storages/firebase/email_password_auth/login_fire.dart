import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced/storages/firebase/email_password_auth/signup_fire.dart';
import 'Fire_function.dart';
import 'home_fire.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey:  "AIzaSyDYrDyx_hirkEI9UR0xncX7JzzFasuoP_Q",
          appId: "1:119405132167:android:6c00ea5bb3b94db0e4fb22",
          messagingSenderId: " ",
          projectId: "fir-practice-section"));
  User? user = FirebaseAuth.instance.currentUser;
  runApp(MaterialApp(
    home: user == null ? login_fire() : Home_fire(),

  ));
}

class login_fire extends StatelessWidget {
  var email_cntrl = TextEditingController();
  var password_cntrl = TextEditingController();

  // const signup_fire({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("login"),
          titleTextStyle: TextStyle(fontSize: 20),
          backgroundColor: Colors.green),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "login here",
              style: TextStyle(fontSize: 25, color: Colors.blue),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: email_cntrl,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: "Email"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: password_cntrl,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: "Password"),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  String email = email_cntrl.text.trim();
                  String pass = password_cntrl.text.trim();
                  FirebaseHelper()
                      .loginUser(email: email, pwd: pass)
                      .then((result) {
                    if (result == null) {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => Home_fire()));
                    } else {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(result)));
                    }
                  });
                },
                child: Text("login")),
            TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => signup_fire()));
                },
                child: Text("dont have an account register here"))
          ],
        ),
      ),
    );
  }
}
