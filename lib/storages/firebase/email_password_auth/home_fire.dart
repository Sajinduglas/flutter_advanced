import 'package:flutter/material.dart';

import 'Fire_function.dart';
import 'login_fire.dart';

class Home_fire extends StatelessWidget {
  const Home_fire({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ElevatedButton(
          onPressed: () {
            FirebaseHelper().logout().then((value) => Navigator.push(context,
                MaterialPageRoute(builder: (context) => login_fire())));
          },
          child: Text("loggout")),
    );
  }
}
