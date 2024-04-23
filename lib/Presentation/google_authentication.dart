import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../FirebaseAuthentication/AuthServices.dart';
import 'UserInfoScreen.dart';

class GoogleAuthentication extends StatefulWidget {
  const GoogleAuthentication({super.key});

  @override
  State<GoogleAuthentication> createState() => _GoogleAuthenticationState();
}

class _GoogleAuthenticationState extends State<GoogleAuthentication> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
          image: AssetImage('assets/Images/intro_screenImage.png'),
          fit: BoxFit.fill,
        ),
      ),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 500.0),
            child: SizedBox(
              width: 343,
              child: Text(
                softWrap: true,
                'Welcome to PostElite’s',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF1D2129),
                  fontSize: 30,
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.w900,
                  height: 0.07,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 55.0),
            child: Text(
              'Sukanya Samriddhi Yojana Calculator',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF1D2129),
                fontSize: 18,
                fontFamily: 'Nunito',
                fontWeight: FontWeight.w700,
                height: 0.06,
                decoration: TextDecoration.none,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 25.0),
            child: Text(
              "Empowering Your Daughter's Future",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF3490F9),
                fontSize: 14,
                fontFamily: 'Nunito',
                fontWeight: FontWeight.w700,
                height: 0.07,
                decoration: TextDecoration.none,
              ),
            ),
          ),
        Padding(
          padding: const EdgeInsets.only(top: 100.0,left: 60,right: 50),
          child: ElevatedButton(onPressed: (){
            signInWithGoogle(context, false);

          }, child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset('assets/Images/googlelogin.svg'),
              const SizedBox(width: 10,),
              const Text('Sign in with Google',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF1D2129),
                  fontSize: 18,
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.w700,
                  height: 0.06,
                  decoration: TextDecoration.none,
                ),
              )
            ],)),
        ),
        ],
      ),

    );
  }
}
