import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyDYrDyx_hirkEI9UR0xncX7JzzFasuoP_Q",
          appId: "1:119405132167:android:6c00ea5bb3b94db0e4fb22",
          messagingSenderId: " ",
          projectId: "fir-new-flutter-project",
          storageBucket: "fir-new-flutter-project.appspot.com"));
  runApp(MaterialApp(
    home: FireBaseCrud(),
  ));
}

class FireBaseCrud extends StatefulWidget {
  const FireBaseCrud({super.key});

  @override
  State<FireBaseCrud> createState() => _FireBaseCrudState();
}

class _FireBaseCrudState extends State<FireBaseCrud> {
  var name_cntl = TextEditingController();
  var Email_cntrl = TextEditingController();
  late CollectionReference _userCollection;///collection instance create cheyanam it is similar to table of sqflite we need to create table name

  @override
  void initState() {
    _userCollection = FirebaseFirestore.instance.collection("users");
    super.initState(  );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Firebase clod storage"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: name_cntl,
              decoration: InputDecoration(
                  labelText: "Name", border: OutlineInputBorder()),
            ),
            TextField(
              controller: Email_cntrl,
              decoration: InputDecoration(
                  labelText: "Email", border: OutlineInputBorder()),
            ),
            ElevatedButton(
                onPressed: () {
                  adduser();
                },
                child: Text("Add user")),

            StreamBuilder<QuerySnapshot>(
                stream: getUser(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error ${snapshot.error}');
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }
                  final users = snapshot.data!.docs;
                  return Expanded(
                      child: ListView.builder(
                          itemCount: users.length,
                          itemBuilder: (context, index) {
                            final user = users[index];
                            final userID = user.id;
                            final userName = user['name'];
                            final userEmail = user['email'];
                            return ListTile(
                              title: Text('$userName'),
                              subtitle: Text('$userEmail'),
                              trailing: Wrap(
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        editUser(userID);
                                      },
                                      icon: const Icon(Icons.edit)),
                                  IconButton(
                                      onPressed: () {
                                        deleteUser(userID);
                                      },
                                      icon: const Icon(Icons.delete))
                                ],
                              ),
                            );
                          }));
                })
          ],
        ),
      ),
    );
  }

  void editUser(var id) {
    showDialog(
        context: context,
        builder: (context) {
          final newname_cntlr = TextEditingController();
          final newemail_cntrlr = TextEditingController();

          return AlertDialog(
            title: const Text("Update User"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: newname_cntlr,
                  decoration: const InputDecoration(
                      hintText: "Enter name", border: OutlineInputBorder()),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextField(
                  controller: newemail_cntrlr,
                  decoration: const InputDecoration(
                      hintText: "Enter name", border: OutlineInputBorder()),
                ),
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    updateUser(id, newname_cntlr.text, newemail_cntrlr.text)
                        .then((value) {
                      Navigator.pop(context);
                    });
                  },
                  child: const Text("Update"))
            ],
          );
        });
  }

  ///creste user
  
  Future<void> adduser() async {
    return _userCollection
        .add({'name': name_cntl.text, 'email': Email_cntrl.text}).then((value) {
      print("user added Succesfully"); //or snackbar
      name_cntl.clear();
      Email_cntrl.clear();
    }).catchError((error) {
      print("failed to add user $error");
    });
  }
  
///read user
  ///
  Stream<QuerySnapshot> getUser() {
    return _userCollection.snapshots();
  }

  ///update user
  Future<void> updateUser(var id, String newname, String newemail) {
    return _userCollection
        .doc(id)
        .update({'name': newname, "email": newemail}).then((value) {
      print("User Updated Successfully");
    }).catchError((error) {
      print("User data Updation failed $error");
    });
  }

  ///delete user

  Future<void> deleteUser(var id) {
    return _userCollection.doc(id).delete().then((value) {
      print("User Deleted Successfully");
    }).catchError((error) {
      print("User deletion failed $error");
    });
  }
}
