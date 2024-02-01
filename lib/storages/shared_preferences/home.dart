import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login.dart';

class Home_shared extends StatefulWidget {
  const Home_shared({super.key});

  @override
  State<Home_shared> createState() => _Home_sharedState();
}

class _Home_sharedState extends State<Home_shared> {
  late SharedPreferences preferences;
  String? username;

  @override
  void initState() {
    fetchdata();
    super.initState();
  }
  void fetchdata()async {
    preferences= await SharedPreferences.getInstance();
    setState(() {
      username=preferences.getString("username");
    });
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text("welcome $username"),
            elevation: 5
      ),
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              preferences.setBool('newuser', true);
              Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginShared()));
            },
            child: Text("LogOut")),
      ),
    );
  }


}
 