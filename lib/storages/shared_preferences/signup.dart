import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login.dart';



class Register_Shared extends StatefulWidget {
  const Register_Shared({super.key});

  @override
  State<Register_Shared> createState() => _Register_SharedState();
}

class _Register_SharedState extends State<Register_Shared> {
  var formkey = GlobalKey<FormState>();
  var uname_ctrl = TextEditingController();
  var phone_ctrl = TextEditingController();
  var pass_ctrl = TextEditingController();
  late SharedPreferences preferences;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("signup"),
      ),
      body: Center(
          child: Form(
              key: formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(), hintText: "username"),
                      validator: (username) {
                        if (username!.isEmpty || !username.contains("@")) {
                          return "Invalid username";
                        } else {
                          return null;
                        }
                      },
                      controller: uname_ctrl,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: TextFormField(
                      decoration: InputDecoration(border: OutlineInputBorder(),hintText: "password"),
                      validator: (password) {
                        if (password!.isEmpty || password.length < 6) {
                          return "password is empty /password length should be >6";
                        } else {
                          return null;
                        }
                      },
                      controller: pass_ctrl,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: TextFormField(
                      decoration: InputDecoration(border: OutlineInputBorder(),hintText: "Phonenumber"),
                      validator: (phonenumber) {
                        if (phonenumber!.isEmpty || phonenumber.length < 10) {
                          return "phonenumber is empty /phonenumber length should be 10 digits";
                        } else {
                          return null;
                        }
                      },
                      controller: phone_ctrl,
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        var valid = formkey.currentState!.validate();
                        if (valid == true) {
                          storedate();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("invalid input")));
                        }
                      },
                      child: Text("Signup"))
                ],
              ))),
    );
  }

  void storedate() async {
    String uname = uname_ctrl.text;
    String password = pass_ctrl.text;
    //int phone_num = phone_controller.text as int;
   int phonenumber= int.parse(phone_ctrl.text); // convert string to integer
    preferences = await SharedPreferences.getInstance();
    preferences.setString("username", uname);
    preferences.setString("pass", password);
    preferences.setInt("phoneno", phonenumber);
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => LoginShared()));
  }
}
