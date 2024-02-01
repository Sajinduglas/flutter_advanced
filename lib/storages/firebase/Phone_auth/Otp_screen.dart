import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'homepage.dart';

class Otp_scrren extends StatefulWidget {
  String verificationid;

  Otp_scrren({super.key, required this.verificationid});

  @override
  State<Otp_scrren> createState() => _Otp_scrrenState();
}

class _Otp_scrrenState extends State<Otp_scrren> {
  var otp_cntrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("OTP screen"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: TextField(
              controller: otp_cntrl,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  hintText: "Enter The otp",
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
                try {
                  PhoneAuthCredential credential =
                      await PhoneAuthProvider.credential(
                          verificationId: widget.verificationid,
                          smsCode: otp_cntrl.text.toString());
                  FirebaseAuth.instance.signInWithCredential(credential).then(
                      (value) => Navigator.push(context,
                          MaterialPageRoute(builder: (context) => homePage())));
                } catch (ex) {
                  log(ex.toString());
                }
              },
              child: Text("Verify Otp"))
        ],
      ),
    );
  }
}
