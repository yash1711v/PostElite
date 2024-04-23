import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:post_elite/Presentation/AboutScreen.dart';
import 'package:post_elite/Presentation/Subscription.dart';
import 'package:post_elite/Presentation/google_authentication.dart';
import 'package:post_elite/SharedPref/Sharedpref.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../FirebaseAuthentication/AuthServices.dart';
import 'UserInfoScreen.dart';
import 'home_screen.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Future<void> RateAndShareApp() async {
    const url = 'https://play.google.com/store/apps/details?id=com.habitapps.HabitUp'; // Replace with your privacy policy URL
    await launchUrl(Uri.parse(url));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(40,60), child: Appbar(Padding(
        padding: const EdgeInsets.only(right: 20.0),
        child: SvgPicture.asset(
          "assets/Images/profilepicIcon.svg",
          width: 24,
          height: 24,
          color: Colors.black,
        ),
      )),

      ),
      body: Column(

        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Container(
                  width: 360,
                  height: 400,
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(width: 1, color: Color(0xFF3491FA)),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: 360,
                        height: 65,
                        decoration: const ShapeDecoration(
                          color: Color(0xFF3491FA),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(11),
                              topRight: Radius.circular(11),
                            ),
                          ),
                        ),
                        child: Row(
                          children: [
                            Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: SvgPicture.asset("assets/Images/profilepicIcon.svg"),),
                            const Padding(
                              padding: EdgeInsets.only(left: 15.0),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Hi, Mr. Ramavath Mothilal\n',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontFamily: 'Nunito',
                                        fontWeight: FontWeight.bold,
                                        height: 0.09,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                      'Your Subscription will expire on: 21/03/2025',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontFamily: 'Nunito',
                                        fontWeight: FontWeight.w700,
                                        height: 0.14,
                                      ),
                                    )
                                  ]),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),

                      GestureDetector(
                        onTap: (){
                          Get.to(() => const UserInfoScreen());
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                "assets/Images/profilepicIcon.svg",
                                color: Colors.black,
                                width: 24,
                                height: 24,
                              ),
                              const Padding(
                                padding:
                                    EdgeInsets.only(left: 16.0, ),
                                child: SizedBox(
                                  width: 240,
                                  child: Text(
                                    "My Profile",
                                    style: TextStyle(
                                      color: Color(0xFF1D2129),
                                      fontSize: 16,
                                      fontFamily: 'Nunito',
                                      fontWeight: FontWeight.w700,
                                      height: 0.08,
                                    ),
                                  ),
                                ),
                              ),
                              SvgPicture.asset(
                                "assets/Images/rightsukanyaarrow.svg",
                                color: Colors.black,
                                width: 24,
                                height: 24,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 65.0),
                        child: Divider(
                          color: Colors.grey,
                          thickness: 0.5,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      GestureDetector(
                        onTap: (){
                          Get.to(() => const Subscription());
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                "assets/Images/SubscriptionLogo.svg",
                                color: Colors.black,
                                width: 24,
                                height: 24,
                              ),
                              const Padding(
                                padding:
                                    EdgeInsets.only(left: 16.0, ),
                                child: SizedBox(
                                  width: 240,
                                  child: Text(
                                    "Subscription",
                                    style: TextStyle(
                                      color: Color(0xFF1D2129),
                                      fontSize: 16,
                                      fontFamily: 'Nunito',
                                      fontWeight: FontWeight.w700,
                                      height: 0.08,
                                    ),
                                  ),
                                ),
                              ),
                              SvgPicture.asset(
                                "assets/Images/rightsukanyaarrow.svg",
                                color: Colors.black,
                                width: 24,
                                height: 24,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 65.0),
                        child: Divider(
                          color: Colors.grey,
                          thickness: 0.5,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      GestureDetector(
                        onTap: (){
                          RateAndShareApp();
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                "assets/Images/rateus.svg",
                                color: Colors.black,
                                width: 24,
                                height: 24,
                              ),
                              const Padding(
                                padding:
                                    EdgeInsets.only(left: 16.0, ),
                                child: SizedBox(
                                  width: 240,
                                  child: Text(
                                    "Rate us",
                                    style: TextStyle(
                                      color: Color(0xFF1D2129),
                                      fontSize: 16,
                                      fontFamily: 'Nunito',
                                      fontWeight: FontWeight.w700,
                                      height: 0.08,
                                    ),
                                  ),
                                ),
                              ),
                              SvgPicture.asset(
                                "assets/Images/rightsukanyaarrow.svg",
                                color: Colors.black,
                                width: 24,
                                height: 24,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 65.0),
                        child: Divider(
                          color: Colors.grey,
                          thickness: 0.5,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      GestureDetector(
                        onTap: () async {
                          final urlI='https://play.google.com/store/apps/details?id=com.habitapps.HabitUp';
                          try {
                            await Share.share(
                              'Check out this app: $urlI',
                              subject: 'App Sharing',
                            );
                          } catch (e) {
                            // Handle exceptions, if any
                            print('Error sharing: $e');
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                "assets/Images/share.svg",
                                color: Colors.black,
                                width: 24,
                                height: 24,
                              ),
                              const Padding(
                                padding:
                                    EdgeInsets.only(left: 16.0,),
                                child: SizedBox(
                                  width: 240,
                                  child: Text(
                                    "Share the App",
                                    style: TextStyle(
                                      color: Color(0xFF1D2129),
                                      fontSize: 16,
                                      fontFamily: 'Nunito',
                                      fontWeight: FontWeight.w700,
                                      height: 0.08,
                                    ),
                                  ),
                                ),
                              ),
                              SvgPicture.asset(
                                "assets/Images/rightsukanyaarrow.svg",
                                color: Colors.black,
                                width: 24,
                                height: 24,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 65.0),
                        child: Divider(
                          color: Colors.grey,
                          thickness: 0.5,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      GestureDetector(
                        onTap: (){
                          Get.to(() => const AboutScreen());
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                "assets/Images/Infoicon.svg",
                                color: Colors.black,
                                width: 24,
                                height: 24,
                              ),
                              const Padding(
                                padding:
                                    EdgeInsets.only(left: 16.0, ),
                                child: SizedBox(
                                  width: 240,
                                  child: Text(
                                    "About",
                                    style: TextStyle(
                                      color: Color(0xFF1D2129),
                                      fontSize: 16,
                                      fontFamily: 'Nunito',
                                      fontWeight: FontWeight.w700,
                                      height: 0.08,
                                    ),
                                  ),
                                ),
                              ),
                              SvgPicture.asset(
                                "assets/Images/rightsukanyaarrow.svg",
                                color: Colors.black,
                                width: 24,
                                height: 24,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 65.0),
                        child: Divider(
                          color: Colors.grey,
                          thickness: 0.5,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      GestureDetector(
                        onTap: (){
                          signout().then((value) {
                            Sharedpref().setEmail("");
                            Sharedpref().setUid("");
                            Sharedpref().setUsername("");
                            Sharedpref().setMobile("");
                            Get.offAll(() => const GoogleAuthentication());
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                "assets/Images/Logout.svg",
                                color: Colors.black,
                                width: 24,
                                height: 24,
                              ),
                              const Padding(
                                padding:
                                    EdgeInsets.only(left: 16.0, ),
                                child: SizedBox(
                                  width: 235,
                                  child: Text(
                                    "Logout",
                                    style: TextStyle(
                                      color: Color(0xFF1D2129),
                                      fontSize: 16,
                                      fontFamily: 'Nunito',
                                      fontWeight: FontWeight.w700,
                                      height: 0.08,
                                    ),
                                  ),
                                ),
                              ),

                              SvgPicture.asset(
                                "assets/Images/rightsukanyaarrow.svg",
                                color: Colors.black,
                                width: 24,
                                height: 24,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
