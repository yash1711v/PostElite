import 'dart:convert';
import 'dart:ui';

import 'package:shared_preferences/shared_preferences.dart';



class Sharedpref{








  //Setting and getting of  Uid
  setUid(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("Uid", value);
  }

  getUid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
   String Uid = prefs.getString("Uid")??"";
   return Uid;
  }

  //Setting and getting of  Username
  setUsername(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("Username", value);
  }

  getUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String Username = prefs.getString("Username")??"";
    return Username;
  }

  //Setting and getting of  Email
  setEmail(String value) async {
    print("Email id coming to save is ---> $value");
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("Email", value);
  }

  getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = prefs.getString("Email")??"";
    print("Email id giving from to sharedpref is ---> $email");
    return email;
  }


  //Setting and getting of  Uid
  setMobile(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("Mobile", value);
  }

  getMobile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String Uid = prefs.getString("Mobile")??"";
    return Uid;
  }
  setid(int value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("id", value);
  }

  getid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int id = prefs.getInt("id")??0;
    return id;
  }

 }










