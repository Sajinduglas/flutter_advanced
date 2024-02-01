import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'Otp_screen.dart';

class phoneAuth extends StatefulWidget {
  const phoneAuth({super.key});

  @override
  State<phoneAuth> createState() => _phoneAuthState();
}

class _phoneAuthState extends State<phoneAuth> {
  var phone_cntrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Phone Auth"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: TextField(
              controller: phone_cntrl,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  hintText: "Enter phone number",
                  suffixIcon: Icon(Icons.phone),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () async {
                await FirebaseAuth.instance.verifyPhoneNumber(
                  phoneNumber: phone_cntrl.text.toString(),
                  verificationCompleted: (PhoneAuthCredential credential) {},
                  verificationFailed: (FirebaseAuthException e) {},
                  codeSent: (String verificationId, int? resendToken) {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Otp_scrren(verificationid:verificationId ,)));
                  },
                  codeAutoRetrievalTimeout: (String verificationId) {},
                );
              },
              child: Text("Verify phone number"))
        ],
      ),
    );
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyDYrDyx_hirkEI9UR0xncX7JzzFasuoP_Q",
          appId: "1:119405132167:android:6c00ea5bb3b94db0e4fb22",
          messagingSenderId: " ",
          projectId: "fir-new-flutter-project"));

  runApp(MaterialApp(
    home: phoneAuth(),
  ));
}
