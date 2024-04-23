// Google sign in and Signup
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:post_elite/SharedPref/Sharedpref.dart';

import '../Presentation/UserInfoScreen.dart';
final FirebaseAuth _auth = FirebaseAuth.instance;

Future signout() async {
  try {

    return await _auth.signOut(); //signout method of Firebase Auth
  } catch (e) {
    print(e.toString());
  }
}
signInWithGoogle(BuildContext context, bool isGuest) async {
  await GoogleSignIn().signIn().then((value1) {
    Future.delayed(Duration(seconds: 1)).then((value) async {
      //Authenticating with google to get acces of the account
      final GoogleSignInAuthentication googleSignInAuthentication =
      await value1!.authentication;

      //fetching the user credentials
      final AuthCredential authCredential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken);

      //Authenticating with the coming credentials
      await _auth.signInWithCredential(authCredential).then((value2) async {
      print(value2.user);
      print(value2.user?.displayName);
      print(value2.user?.email);
      print(value2.user?.uid);
        await Sharedpref().setUid(value2.user!.uid);
        await Sharedpref().setEmail(value2.user!.email??"");
      await Sharedpref().setUsername(value2.user!.displayName??"");
        Get.to(()=>UserInfoScreen());
        // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        //     backgroundColor: Colors.white,
        //     shape: RoundedRectangleBorder(
        //       // side: BorderSide(width: borderWidth, color: borderColor),
        //       borderRadius: BorderRadius.all(Radius.circular(10)),
        //     ),
        //     content: Text(
        //       "Welcome",
        //       style: TextStyle(color: Colors.black),
        //     )));
      }).catchError((e) {
        // error are coming fronm here
        print(e);
        String errorMessage = _extractErrorMessage(e.toString());
        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        //     backgroundColor: Colors.white,
        //     shape: const RoundedRectangleBorder(
        //       // side: BorderSide(width: borderWidth, color: borderColor),
        //       borderRadius: BorderRadius.all(Radius.circular(10)),
        //     ),
        //     content: Text(
        //       errorMessage,
        //       style: TextStyle(color: Colors.black),
        //     )));
      });
    });
  });
}
String _extractErrorMessage(String errorString) {
  // Regular expression pattern to match the relevant part of the error message
  RegExp regExp = RegExp(r'\[.*?\] (.*)');
  Match? match = regExp.firstMatch(errorString);

  // If a match is found, return the relevant part of the error message, else return the original error message
  return match != null ? match.group(1)! : errorString;
}
