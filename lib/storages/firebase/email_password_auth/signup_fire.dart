import 'package:flutter/material.dart';
import 'Fire_function.dart';
import 'login_fire.dart';

class signup_fire extends StatefulWidget {
  @override
  State<signup_fire> createState() => _signup_fireState();
}

class _signup_fireState extends State<signup_fire> {
  var email_cntrl = TextEditingController();
  var password_cntrl = TextEditingController();

  // const signup_fire({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Signup"),
          titleTextStyle: TextStyle(fontSize: 20),
          backgroundColor: Colors.green),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Register here",
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
          //  ElevatedButton(onPressed: () {}, child: Text("login")),
            ElevatedButton(onPressed: (){
              String email=email_cntrl.text.trim();
              String pass=password_cntrl.text.trim();
              FirebaseHelper().registerUser(email:email,pwd:pass).then((result) {
                if(result==null){
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => login_fire()));
                }else{
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result)));
                }
              });
            }, child: Text("register"))
          ],
        ),
      ),
    );
  }
}
