import 'package:flutter/material.dart';
import 'package:flutter_advanced/storages/sqflite/sq_login.dart';
import 'package:flutter_advanced/storages/sqflite/sqflite_function.dart';



class sq_signup extends StatelessWidget {
  var formkey = GlobalKey<FormState>();//
  var name_ctrl = TextEditingController();
  var email_ctrl = TextEditingController();
  var pass_ctrl = TextEditingController();

  sq_signup({super.key});

  @override
  Widget build(BuildContext context) {
    void register_user(String name, String email, String password) async {
      var id = await Sql_functions.addUser(name, email, password);
      print(id);
      if (id != null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => sq_login()));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Registration Failed")));
      }
    }

    return Scaffold(
      body: Center(
        child: Form(
          key: formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: name_ctrl,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), hintText: "name"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: email_ctrl,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), hintText: "Email"),
                  validator: (email) {
                    if (email!.isEmpty || !email.contains("@")) {
                      return "Invalid username or field is empty";
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: pass_ctrl,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), hintText: "password"),
                  validator: (pass) {
                    if (pass!.isEmpty || pass.length < 6) {
                      return "Password length should be  >6 or field is empty";
                    }
                  },
                ),
              ),
              ElevatedButton(
                  onPressed: ()async {
                    var valid = formkey.currentState!.validate();
                    if (valid == true) {
                      var users =await Sql_functions.check_user_already_registered(email_ctrl.text);
                      if(users.isNotEmpty){
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("user already registered")));
                      }else {
                        register_user(
                            name_ctrl.text, email_ctrl.text, pass_ctrl.text);
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Please verify all the fields")));
                    }
                  },
                  child: Text("Register now"))
            ],
          ),
        ),
      ),
    );
  }
}
