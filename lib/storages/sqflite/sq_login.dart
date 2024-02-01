import 'package:flutter/material.dart';
import 'package:flutter_advanced/storages/sqflite/sq_admin_home.dart';
import 'package:flutter_advanced/storages/sqflite/sq_registration.dart';
import 'package:flutter_advanced/storages/sqflite/sq_user_home.dart';
import 'package:flutter_advanced/storages/sqflite/sqflite_function.dart';
void main() {
  runApp(MaterialApp(home: sq_login(),debugShowCheckedModeBanner: false,));
}
class sq_login extends StatelessWidget {
  var formkey = GlobalKey<FormState>();
  var email_ctrl = TextEditingController();
  var pass_ctrl = TextEditingController();

  sq_login({super.key});

  @override
  Widget build(BuildContext context) {
    void login_user(String email, String pwd) async {
      //admin login
      if (email == 'admin@gmail' && pwd == "admin123"){
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context)=>sq_admin_home()));
      }else{
        //check if user is exist in db
        var data = await Sql_functions.checkUserExist(email,pwd);

        if(data.isNotEmpty){
          Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context)=> db_user_home(data: data)));
        }
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
                padding: const EdgeInsets.all(12.0),
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
                padding: const EdgeInsets.all(12.0),
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
              ElevatedButton(onPressed: () {
    var valid = formkey.currentState!.validate();
    if (valid) {
      login_user(email_ctrl.text, pass_ctrl.text);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Please Verify All the Fields")));
    }
              },
                  child: const Text("Login Now")),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>sq_signup()));
                  },
                  child: Text("dont have an account register here"))
            ],
          ),
        ),
      ),
    );
  }


}
