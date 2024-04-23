import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'home_screen.dart';

class Subscription extends StatefulWidget {
  const Subscription({super.key});

  @override
  State<Subscription> createState() => _SubscriptionState();
}

class _SubscriptionState extends State<Subscription> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(40,60),
        child:     AppBar(
          backgroundColor: Colors.white,
          elevation: 2,
          leading: Center(
            child: IconButton(
              onPressed: () {
                Get.back();
              }, icon: Icon(Icons.arrow_back_rounded,
                color: Color(0xFF000000)),
            ),
          ),
          title: const Text(
            'Subscription',
            style: TextStyle(
              color: Color(0xFF1D2129),
              fontSize: 18,
              fontFamily: 'Nunito',
              fontWeight: FontWeight.w700,
              height: 0.07,
            ),
          ),
          centerTitle: false,
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: SvgPicture.asset(
                "assets/Images/SubscriptionLogo.svg",
                color: Colors.black,
                width: 24,
                height: 24,
              ),
            ),
          ],
        ),
      ),




      body: Column(
        children: [

          Padding(
            padding: const EdgeInsets.only(top: 25.0),
            child: Center(
              child: Container(
                  width: 360,
                  height: 275,
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 1, color: Color(0xFF3491FA)),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: 360,
                        height: 48,
                        decoration: ShapeDecoration(
                          color: Color(0xFF3491FA),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(11),
                              topRight: Radius.circular(11),
                            ),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Subscribed for premium app features',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.w900,
                                height: 0.08,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Container(
                          width: 343,
                          height: 20,
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 120,
                                child: Text(
                                  'Full Name',
                                  style: TextStyle(
                                    color: Color(0xFF1D2129),
                                    fontSize: 14,
                                    fontFamily: 'Nunito',
                                    fontWeight: FontWeight.w600,
                                    height: 0.11,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                ':',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFF1D2129),
                                  fontSize: 14,
                                  fontFamily: 'Nunito',
                                  fontWeight: FontWeight.w700,
                                  height: 0.11,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Expanded(
                                child: SizedBox(
                                  child: Text(
                                    'Mr. R Mothilal',
                                    style: TextStyle(
                                      color: Color(0xFF1D2129),
                                      fontSize: 14,
                                      fontFamily: 'Nunito',
                                      fontWeight: FontWeight.w700,
                                      height: 0.11,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Container(
                          width: 343,
                          height: 20,
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 120,
                                child: Text(
                                  'Reg. mail ID',
                                  style: TextStyle(
                                    color: Color(0xFF1D2129),
                                    fontSize: 14,
                                    fontFamily: 'Nunito',
                                    fontWeight: FontWeight.w600,
                                    height: 0.11,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                ':',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFF1D2129),
                                  fontSize: 14,
                                  fontFamily: 'Nunito',
                                  fontWeight: FontWeight.w700,
                                  height: 0.11,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Expanded(
                                child: SizedBox(
                                  child: Text(
                                    'abcxyz@gmail.com',
                                    style: TextStyle(
                                      color: Color(0xFF1D2129),
                                      fontSize: 14,
                                      fontFamily: 'Nunito',
                                      fontWeight: FontWeight.w700,
                                      height: 0.11,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Container(
                          width: 343,
                          height: 20,
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 120,
                                child: Text(
                                  'Mobile Number',
                                  style: TextStyle(
                                    color: Color(0xFF1D2129),
                                    fontSize: 14,
                                    fontFamily: 'Nunito',
                                    fontWeight: FontWeight.w600,
                                    height: 0.11,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                ':',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFF1D2129),
                                  fontSize: 14,
                                  fontFamily: 'Nunito',
                                  fontWeight: FontWeight.w700,
                                  height: 0.11,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Expanded(
                                child: SizedBox(
                                  child: Text(
                                    '+91 90000 12345',
                                    style: TextStyle(
                                      color: Color(0xFF1D2129),
                                      fontSize: 14,
                                      fontFamily: 'Nunito',
                                      fontWeight: FontWeight.w700,
                                      height: 0.11,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Container(
                          width: 343,
                          height: 20,
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 120,
                                child: Text(
                                  'Registration Date',
                                  style: TextStyle(
                                    color: Color(0xFF1D2129),
                                    fontSize: 14,
                                    fontFamily: 'Nunito',
                                    fontWeight: FontWeight.w600,
                                    height: 0.11,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                ':',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFF1D2129),
                                  fontSize: 14,
                                  fontFamily: 'Nunito',
                                  fontWeight: FontWeight.w700,
                                  height: 0.11,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Expanded(
                                child: SizedBox(
                                  child: Text(
                                    '04/04/2024 09:41:00',
                                    style: TextStyle(
                                      color: Color(0xFF1D2129),
                                      fontSize: 14,
                                      fontFamily: 'Nunito',
                                      fontWeight: FontWeight.w700,
                                      height: 0.11,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Container(
                          width: 343,
                          height: 20,
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 120,
                                child: Text(
                                  'You’ve subscribed',
                                  style: TextStyle(
                                    color: Color(0xFF1D2129),
                                    fontSize: 14,
                                    fontFamily: 'Nunito',
                                    fontWeight: FontWeight.w600,
                                    height: 0.11,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                ':',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFF1D2129),
                                  fontSize: 14,
                                  fontFamily: 'Nunito',
                                  fontWeight: FontWeight.w700,
                                  height: 0.11,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Expanded(
                                child: SizedBox(
                                  child: Text(
                                    'Free Trail (20 Days)',
                                    style: TextStyle(
                                      color: Color(0xFF1D2129),
                                      fontSize: 16,
                                      fontFamily: 'Nunito',
                                      fontWeight: FontWeight.w600,
                                      height: 0.08,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Container(
                          width: 343,
                          height: 20,
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 120,
                                child: Text(
                                  'Subscription date',
                                  style: TextStyle(
                                    color: Color(0xFF1D2129),
                                    fontSize: 14,
                                    fontFamily: 'Nunito',
                                    fontWeight: FontWeight.w600,
                                    height: 0.11,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                ':',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFF1D2129),
                                  fontSize: 14,
                                  fontFamily: 'Nunito',
                                  fontWeight: FontWeight.w700,
                                  height: 0.11,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Expanded(
                                child: SizedBox(
                                  child: Text(
                                    '04/04/2024 09:41:00',
                                    style: TextStyle(
                                      color: Color(0xFF1D2129),
                                      fontSize: 14,
                                      fontFamily: 'Nunito',
                                      fontWeight: FontWeight.w700,
                                      height: 0.11,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Container(
                          width: 343,
                          height: 20,
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 120,
                                child: Text(
                                  'Subscription ends',
                                  style: TextStyle(
                                    color: Color(0xFF1D2129),
                                    fontSize: 14,
                                    fontFamily: 'Nunito',
                                    fontWeight: FontWeight.w600,
                                    height: 0.11,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                ':',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFF1D2129),
                                  fontSize: 14,
                                  fontFamily: 'Nunito',
                                  fontWeight: FontWeight.w700,
                                  height: 0.11,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Expanded(
                                child: SizedBox(
                                  child: Text(
                                    '24/04/2024 09:41:00',
                                    style: TextStyle(
                                      color: Color(0xFF1D2129),
                                      fontSize: 14,
                                      fontFamily: 'Nunito',
                                      fontWeight: FontWeight.w700,
                                      height: 0.11,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 25.0),
            child: Container(
                width: 360,
                height: 135,
                clipBehavior: Clip.antiAlias,
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 1, color: Color(0xFF3491FA)),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      width: 360,
                      height: 48,
                      decoration: ShapeDecoration(
                        color: Color(0xFF3491FA),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(11),
                            topRight: Radius.circular(11),
                          ),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Advantages of Premium Version',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontFamily: 'Nunito',
                              fontWeight: FontWeight.w900,
                              height: 0.08,
                            ),
                          ),
                        ],
                      ),
                    ),
                   Padding(
                     padding: const EdgeInsets.only(top: 5.0,right: 65),
                     child: Column(
                       mainAxisAlignment: MainAxisAlignment.start,
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         RichText(
                           text: TextSpan(
                             children: [
                               WidgetSpan(
                                 alignment: PlaceholderAlignment.middle,
                                 child: Text(
                                   '\u2022', // Unicode character for bullet (•)
                                   style: TextStyle(fontSize: 16, color: Colors.black),
                                 ),
                               ),
                               TextSpan(
                                 text: ' Eliminated Advertisements.',
                                 style: TextStyle(color: Colors.black),
                               ),
                             ],
                           ),
                         ),
                         RichText(
                           text: TextSpan(
                             children: [
                               WidgetSpan(
                                 alignment: PlaceholderAlignment.middle,
                                 child: Text(
                                   '\u2022', // Unicode character for bullet (•)
                                   style: TextStyle(fontSize: 16, color: Colors.black),
                                 ),
                               ),
                               TextSpan(
                                 text: ' Unlock Premium Presentation Features.',
                                 style: TextStyle(color: Colors.black),
                               ),
                             ],
                           ),
                         ),
                         RichText(
                           text: TextSpan(
                             children: [
                               WidgetSpan(
                                 alignment: PlaceholderAlignment.middle,
                                 child: Text(
                                   '\u2022', // Unicode character for bullet (•)
                                   style: TextStyle(fontSize: 16, color: Colors.black),
                                 ),
                               ),
                               TextSpan(
                                 text: ' Regular Updates Provided.',
                                 style: TextStyle(color: Colors.black),
                               ),
                             ],
                           ),
                         ),
                       ],
                     ),
                   )


                  ],
                )),
          )
        ],
      ),
    );
  }
}
