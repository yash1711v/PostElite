import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/route_manager.dart';
import 'package:post_elite/Presentation/MainScreen.dart';
import 'package:post_elite/Presentation/home_screen.dart';
import 'package:post_elite/SharedPref/Sharedpref.dart';

import 'google_authentication.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
     Future.delayed(Duration(seconds: 1)).then((value) async {
       String Uid= await Sharedpref().getUid();
       if(Uid!=""&& Uid!=null){
          Get.to(()=>MainScreen());
       }
       else{
        Get.to(() => GoogleAuthentication());
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 400.0),
            child: Center(child: SvgPicture.asset('assets/Images/Logo.svg')),
          ),
        Spacer(),
          Text(
            'Powered by V Cube Tech Services',
            style: TextStyle(
              color: Color(0xFFF63031),
              fontSize: 14,
              fontFamily: 'Nunito',
              fontWeight: FontWeight.w400,
              height: 0.11,
            ),
          ),
          SizedBox(height: 45,)
        ],
      ),
    );
  }
}
