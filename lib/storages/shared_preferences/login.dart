import 'package:flutter/material.dart';
import 'package:flutter_advanced/storages/shared_preferences/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home.dart';

void main() {
  runApp(MaterialApp(
    home: LoginShared(),
  ));
}

class LoginShared extends StatefulWidget {
  const LoginShared({super.key});

  @override
  State<LoginShared> createState() => _LoginSharedState();
}

class _LoginSharedState extends State<LoginShared> {
  var formkey = GlobalKey<FormState>();
  late SharedPreferences preferences;
  var uname_ctrl = TextEditingController();
  var pass_ctrl = TextEditingController();
  late bool newuser;

  @override
  void initState() {
    check_if_user_is_already_login();
    super.initState();
  }

// whenever we open the app check the user is logged in or not so we should create this method inside initState
  void check_if_user_is_already_login() async {
    preferences = await SharedPreferences.getInstance();
    // ?? -  if the given condition is null second statement will execute
    // the key"new user" will execute only when  we click on login button  .. before that it will be null
    newuser = preferences.getBool("newuser") ?? true;
    if (newuser == false) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Home_shared()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                          return "Invalid or Empty UserName!!!";
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
                      decoration: InputDecoration(
                          border: OutlineInputBorder(borderRadius:BorderRadius.circular(5) ), hintText: "password"),
                      validator: (password) {
                        if (password!.isEmpty || password.length < 6) {
                          return "Password is empty /Password length should be > 6";
                        } else {
                          return null;
                        }
                      },
                      controller: pass_ctrl,
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        var valid = formkey.currentState!.validate();
                        if (valid == true) {
                          validate_input();
                        }
                      },
                      child: Text("login")),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Register_Shared()));
                      },
                      child: const Text("Not a User?? Register Here!!!"))
                ],
              ))),
    );
  }

  void validate_input() async {
    String uname = uname_ctrl.text;
    String pass = pass_ctrl.text;
    preferences = await SharedPreferences.getInstance();
    //if user is loggged  in then mark it is not aa new user

    preferences.setBool("newuser", false);

    //read the registered values
    String? stored_uname = preferences.getString("username");
    String? stored_password = preferences.getString("pass");

    if (stored_uname == uname && stored_password == pass) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => Home_shared()));
    }
  }
}
