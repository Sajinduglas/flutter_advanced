import 'package:flutter/material.dart';
import 'package:flutter_advanced/storages/sqflite/sqflite_function.dart';

class sq_admin_home extends StatefulWidget {
  sq_admin_home({super.key});

  @override
  State<sq_admin_home> createState() => _sq_admin_homeState();
}

class _sq_admin_homeState extends State<sq_admin_home> {
  List<Map<String, dynamic>> users = [];
@override
  void initState() {
   getallusers();
    super.initState();
  }
  void getallusers() async{
  var userFromDb =await Sql_functions.getAllusers();
  setState(() {
    users=userFromDb;
  });
  }// to store the details  all users
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("admin panel"),
      ),
      body: ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                title: Text(users[index]["name"]),
                subtitle: Text(users[index]["email"]),
                trailing:
                    IconButton(onPressed: (){
                      deleteuser(users[index]["id"]);
                    }, icon: Icon(Icons.delete)),
              ),
            );
          }),
    );
  }

  void deleteuser(int id) async{
    await Sql_functions.dltuser(id);
    getallusers();
  }


}
