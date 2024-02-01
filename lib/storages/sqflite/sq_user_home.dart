import 'package:flutter/material.dart';
import 'package:flutter_advanced/storages/sqflite/sqflite_function.dart';

class db_user_home extends StatefulWidget {
  final data;

  db_user_home({super.key, required this.data});

  @override
  State<db_user_home> createState() => _db_user_homeState();
}

class _db_user_homeState extends State<db_user_home> {
  var name,email;
  var cemail = TextEditingController();
  var cname = TextEditingController();
  @override
  void initState() {
    // ///fetching the user details and assign it to these instance variables
     name = widget.data[0]['name'];
     email = widget.data[0]["email"];
    super.initState();
  }
  @override
  Widget build(BuildContext context) {


    void editdata() {
      setState(() {
         ///setting the current user details to the text fields inside alert box
        cname.text = name;
        cemail.text = email;
      });
      /// to show the dailogbox
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(
                "Edit data",
                style: TextStyle(fontSize: 20),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: cname,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), hintText: "Edit Name"),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextField(
                    controller: cemail,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), hintText: "Edit Email"),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          name = cname.text;
                          email = cemail.text;
                        });
                        updateuser();
                        Navigator.of(context).pop();
                        // cname.text = "";
                        // cemail.text = "";
                      },
                      child: Text("Update Data"))
                ],
              ),
            );
          });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome $name'),
        elevation: 5,
      ),
      body: Card(
        child: ListTile(
          leading: Icon(Icons.person_outline_outlined),
          title: Text("$name", style: TextStyle(fontSize: 20)),
          subtitle:
              Text("$email", style: TextStyle(fontSize: 20)),
          trailing: IconButton(
              onPressed: () {
                editdata();
              },
              icon: Icon(Icons.edit)),
        ),
      ),
    );
  }

  void updateuser() async{
    await Sql_functions.update(widget.data[0]["id"],name,email);
  }
}
