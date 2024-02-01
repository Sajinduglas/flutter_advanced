import 'package:flutter/material.dart';

class Auth_provider extends ChangeNotifier{
  bool _loggedin =false;
  bool get login => _loggedin;

  void loggedin(){
    _loggedin= true;
    notifyListeners();
  }
  void loggedout(){
    _loggedin= false;
    notifyListeners();
  }
}