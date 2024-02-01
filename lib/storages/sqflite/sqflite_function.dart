import 'package:flutter/src/widgets/editable_text.dart';
import 'package:sqflite/sqflite.dart' as sql;

class Sql_functions {
  ///creating database
  static Future<sql.Database> openOrCreateDb() async {///repeated memory alocationmaran ayittu static
    return sql.openDatabase('users', version: 1,
        onCreate: (sql.Database db, int version) async {
          await createTable(db);
        });
  }
  
  ///creating table to store user data
  static Future<void> createTable(sql.Database db) async {
    await db.execute(
        'CREATE TABLE userdata (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, name TEXT, email TEXT, password TEXT)');
  }

  /// creating new user in the table
  static Future<int> addUser(String name, String email, String password) async {
    var db = await Sql_functions.openOrCreateDb(); // to open database
    var data = {
      'name': name,
      'email': email,
      'password': password
    }; //here keys arae column,values are values from textformfield
    var id = db.insert('userdata', data);
    //  Or
    //var id = db.insert('userdata',{'name':name, 'email':email,'password': password});
    return id;
  }

  /// check the email and password exist in table
  static Future<List<Map>> checkUserExist(String email, String pwd) async {
    var db = await Sql_functions.openOrCreateDb(); // to open database
    final data = await db.rawQuery(
        "SELECT * FROM userdata WHERE email ='$email' AND password ='$pwd' ");
    if (data.isNotEmpty) {
      return data;
    } else {
      return data;
    }
  }

  ///to check  the user is already registered
  static Future<List<Map>> check_user_already_registered(String email) async {
    var db = await Sql_functions.openOrCreateDb(); // to open database
    final user = await db.rawQuery(
        "SELECT * FROM userdata WHERE email ='$email' ");
    if (user.isNotEmpty) {
      return user;
    } else {
      return user;
    }
  }
  /// to read all the users from the db    it is used for admin

  static Future<List<Map<String,dynamic>>> getAllusers() async{
    var db = await Sql_functions.openOrCreateDb(); // to open database
    final allusers =await db.rawQuery("SELECT * FROM userdata");
    return allusers;
  }
/// to delete user
  static Future <void>dltuser(int id) async{
    var db = await Sql_functions.openOrCreateDb(); // to open database
    db.delete("userdata",where: 'id=?', whereArgs: [id]);// doubt
  }

  static Future<int> update(int id, String uname, String uemail) async{
    var db=await Sql_functions.openOrCreateDb();
    final newdata={'name':uname,'email':uemail};
    final newid=await db.update('userdata', newdata,where: 'id = ?',whereArgs: [id]);
    return newid;
    }
}


