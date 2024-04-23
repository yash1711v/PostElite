import 'dart:async';
import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'Schemes/Sukanya.dart';
final Dio dio= Dio();
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Timer _timer;
  late ScrollController _scrollController;
  int _currentIndex = 0;
  final int _totalItems = 2;
  CarouselController buttonCarouselController = CarouselController();

  String interest=8.2.toString();
// Total number of items in the list
  
  Future<String> interestGiving() async {
    try {
      final response = await dio.get(
          "https://admin.vcubetechservices.com/api/ssa-interest",);
      Map<String,dynamic> MapofResponse=json.decode(response.toString());
      print(MapofResponse['data']);
      setState(() {
        interest=MapofResponse['data']['interest'].toString();
      });
    }
    catch(e){
      print(e);
    }

    return interest;
  }

  @override
  void initState() {
    super.initState();
    interestGiving();
    _scrollController = ScrollController();

    _timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      // Increment the current index, reset to 0 if it reaches the last index
      _currentIndex = (_currentIndex + 1) % _totalItems;

      // Calculate the offset based on the current index and the width of each item
      double offset = _currentIndex * MediaQuery.of(context).size.width;

      // Scroll to the calculated offset
      _scrollController.jumpTo(
        offset,
      );
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(40,60), child: Appbar(Padding(
        padding: const EdgeInsets.only(right: 20.0),
        child: SvgPicture.asset(
          "assets/Images/home.svg",
          width: 24,
          height: 24,
        ),
      )),

      ),
      body: SingleChildScrollView(
        child: Column(
          children: [

            Padding(
              padding: const EdgeInsets.only(left: 10.0, top: 10),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 200,
                child: CarouselSlider(
                  items: [
                    Image.asset("assets/Images/sukanyaimage1.png"),
                    Image.asset("assets/Images/sukanya2.png"),
                  ],
                  carouselController: buttonCarouselController,
                  options: CarouselOptions(
                    autoPlay: true,
                    enlargeCenterPage: true,
                    viewportFraction: 0.9,
                    aspectRatio: 2.0,
                    initialPage: 1,
                  ),
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(top: 20,left: 10),
                child: Container(
                  width: 350,
                  height: 345,
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
                    height: 42,
                    clipBehavior: Clip.antiAlias,
                    decoration: const ShapeDecoration(
                      color: Colors.blue,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 1, color: Color(0xFF3491FA)),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(11),
                          topRight: Radius.circular(11),
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: SvgPicture.asset("assets/Images/sukaniyaAletrLogo.svg"),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 10.0),
                          child: SizedBox(
                            width: 267,
                            child: Text(
                              "Sukanya Samriddhi Account (SSA)",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),

                        GestureDetector(
                            onTap: (){
                              interestGiving().then((value) {
                                Get.to(()=>Sukanya(currentInterest: value,));
                              });

                            },
                            child: SvgPicture.asset("assets/Images/rightsukanyaarrow.svg"))
                      ],
                    ),
                    ),
                     Column(
                       children: [
                         Padding(
                           padding: const EdgeInsets.only(top: 15.0),
                           child: Container(
                             width: 343,
                             height: 20,
                             padding: const EdgeInsets.symmetric(horizontal: 12),
                             child: const Row(
                               mainAxisSize: MainAxisSize.min,
                               mainAxisAlignment: MainAxisAlignment.start,
                               crossAxisAlignment: CrossAxisAlignment.center,
                               children: [
                                 Expanded(
                                   child: SizedBox(
                                     child: Text(
                                       'Eligibility',
                                       style: TextStyle(
                                         color: Color(0xFF1D2129),
                                         fontSize: 14,
                                         fontFamily: 'Nunito',
                                         fontWeight: FontWeight.w600,
                                         height: 0.11,
                                       ),
                                     ),
                                   ),
                                 ),
                                 SizedBox(width: 6),
                                 Text(
                                   ':',
                                   textAlign: TextAlign.center,
                                   style: TextStyle(
                                     color: Color(0xFF206CCF),
                                     fontSize: 14,
                                     fontFamily: 'Nunito',
                                     fontWeight: FontWeight.w700,
                                     height: 0.11,
                                   ),
                                 ),
                                 SizedBox(width: 6),
                                 Expanded(
                                   child: SizedBox(
                                     child: Text(
                                       'Girl Child below 10 Yrs',
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
                           padding: const EdgeInsets.only(top: 5.0),
                           child: Container(
                             width: 343,
                             height: 20,
                             padding: const EdgeInsets.symmetric(horizontal: 12),
                             child: const Row(
                               mainAxisSize: MainAxisSize.min,
                               mainAxisAlignment: MainAxisAlignment.start,
                               crossAxisAlignment: CrossAxisAlignment.center,
                               children: [
                                 Expanded(
                                   child: SizedBox(
                                     child: Text(
                                       'Minimum Deposit',
                                       style: TextStyle(
                                         color: Color(0xFF1D2129),
                                         fontSize: 14,
                                         fontFamily: 'Nunito',
                                         fontWeight: FontWeight.w600,
                                         height: 0.11,
                                       ),
                                     ),
                                   ),
                                 ),
                                 SizedBox(width: 6),
                                 Text(
                                   ':',
                                   textAlign: TextAlign.center,
                                   style: TextStyle(
                                     color: Color(0xFF206CCF),
                                     fontSize: 14,
                                     fontFamily: 'Nunito',
                                     fontWeight: FontWeight.w700,
                                     height: 0.11,
                                   ),
                                 ),
                                 SizedBox(width: 6),
                                 Expanded(
                                   child: SizedBox(
                                     child: Text(
                                       '₹ 250/-',
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
                           padding: const EdgeInsets.only(top:5.0),
                           child: Container(
                             width: 343,
                             height: 20,
                             padding: const EdgeInsets.symmetric(horizontal: 12),
                             child: const Row(
                               mainAxisSize: MainAxisSize.min,
                               mainAxisAlignment: MainAxisAlignment.start,
                               crossAxisAlignment: CrossAxisAlignment.center,
                               children: [
                                 Expanded(
                                   child: SizedBox(
                                     child: Text(
                                       'Subsequent Deposit',
                                       style: TextStyle(
                                         color: Color(0xFF1D2129),
                                         fontSize: 14,
                                         fontFamily: 'Nunito',
                                         fontWeight: FontWeight.w600,
                                         height: 0.11,
                                       ),
                                     ),
                                   ),
                                 ),
                                 SizedBox(width: 6),
                                 Text(
                                   ':',
                                   textAlign: TextAlign.center,
                                   style: TextStyle(
                                     color: Color(0xFF206CCF),
                                     fontSize: 14,
                                     fontFamily: 'Nunito',
                                     fontWeight: FontWeight.w700,
                                     height: 0.11,
                                   ),
                                 ),
                                 SizedBox(width: 6),
                                 Expanded(
                                   child: SizedBox(
                                     child: Text(
                                       'Multiple of ₹ 50/-',
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
                           padding: const EdgeInsets.only(top: 5.0),
                           child: Container(
                             width: 343,
                             height: 20,
                             padding: const EdgeInsets.symmetric(horizontal: 12),
                             child: const Row(
                               mainAxisSize: MainAxisSize.min,
                               mainAxisAlignment: MainAxisAlignment.start,
                               crossAxisAlignment: CrossAxisAlignment.center,
                               children: [
                                 Expanded(
                                   child: SizedBox(
                                     child: Text(
                                       'Maximum Deposit in FY',
                                       style: TextStyle(
                                         color: Color(0xFF1D2129),
                                         fontSize: 14,
                                         fontFamily: 'Nunito',
                                         fontWeight: FontWeight.w600,
                                         height: 0.11,
                                       ),
                                     ),
                                   ),
                                 ),
                                 SizedBox(width: 6),
                                 Text(
                                   ':',
                                   textAlign: TextAlign.center,
                                   style: TextStyle(
                                     color: Color(0xFF206CCF),
                                     fontSize: 14,
                                     fontFamily: 'Nunito',
                                     fontWeight: FontWeight.w700,
                                     height: 0.11,
                                   ),
                                 ),
                                 SizedBox(width: 6),
                                 Expanded(
                                   child: SizedBox(
                                     child: Text(
                                       '₹ 1,50,000/-',
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
                           padding: const EdgeInsets.only(top: 5.0),
                           child: Container(
                             width: 343,
                             height: 20,
                             padding: const EdgeInsets.symmetric(horizontal: 12),
                             child: const Row(
                               mainAxisSize: MainAxisSize.min,
                               mainAxisAlignment: MainAxisAlignment.start,
                               crossAxisAlignment: CrossAxisAlignment.center,
                               children: [
                                 Expanded(
                                   child: SizedBox(
                                     child: Text(
                                       'Deposit Period',
                                       style: TextStyle(
                                         color: Color(0xFF1D2129),
                                         fontSize: 14,
                                         fontFamily: 'Nunito',
                                         fontWeight: FontWeight.w600,
                                         height: 0.11,
                                       ),
                                     ),
                                   ),
                                 ),
                                 SizedBox(width: 6),
                                 Text(
                                   ':',
                                   textAlign: TextAlign.center,
                                   style: TextStyle(
                                     color: Color(0xFF206CCF),
                                     fontSize: 14,
                                     fontFamily: 'Nunito',
                                     fontWeight: FontWeight.w700,
                                     height: 0.11,
                                   ),
                                 ),
                                 SizedBox(width: 6),
                                 Expanded(
                                   child: SizedBox(
                                     child: Text(
                                       '15 Years ',
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
                           padding: const EdgeInsets.only(top: 5.0),
                           child: Container(
                             width: 343,
                             height: 20,
                             padding: const EdgeInsets.symmetric(horizontal: 12),
                             child: const Row(
                               mainAxisSize: MainAxisSize.min,
                               mainAxisAlignment: MainAxisAlignment.start,
                               crossAxisAlignment: CrossAxisAlignment.center,
                               children: [
                                 Expanded(
                                   child: SizedBox(
                                     child: Text(
                                       'Freezing Period',
                                       style: TextStyle(
                                         color: Color(0xFF1D2129),
                                         fontSize: 14,
                                         fontFamily: 'Nunito',
                                         fontWeight: FontWeight.w600,
                                         height: 0.11,
                                       ),
                                     ),
                                   ),
                                 ),
                                 SizedBox(width: 6),
                                 Text(
                                   ':',
                                   textAlign: TextAlign.center,
                                   style: TextStyle(
                                     color: Color(0xFF206CCF),
                                     fontSize: 14,
                                     fontFamily: 'Nunito',
                                     fontWeight: FontWeight.w700,
                                     height: 0.11,
                                   ),
                                 ),
                                 SizedBox(width: 6),
                                 Expanded(
                                   child: SizedBox(
                                     child: Text(
                                       '06 Years',
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
                           padding: const EdgeInsets.only(top: 5.0),
                           child: Container(
                             width: 343,
                             height: 20,
                             padding: const EdgeInsets.symmetric(horizontal: 12),
                             child: const Row(
                               mainAxisSize: MainAxisSize.min,
                               mainAxisAlignment: MainAxisAlignment.start,
                               crossAxisAlignment: CrossAxisAlignment.center,
                               children: [
                                 Expanded(
                                   child: SizedBox(
                                     child: Text(
                                       'Maturity Period',
                                       style: TextStyle(
                                         color: Color(0xFF1D2129),
                                         fontSize: 14,
                                         fontFamily: 'Nunito',
                                         fontWeight: FontWeight.w600,
                                         height: 0.11,
                                       ),
                                     ),
                                   ),
                                 ),
                                 SizedBox(width: 6),
                                 Text(
                                   ':',
                                   textAlign: TextAlign.center,
                                   style: TextStyle(
                                     color: Color(0xFF206CCF),
                                     fontSize: 14,
                                     fontFamily: 'Nunito',
                                     fontWeight: FontWeight.w700,
                                     height: 0.11,
                                   ),
                                 ),
                                 SizedBox(width: 6),
                                 Expanded(
                                   child: SizedBox(
                                     child: Text(
                                       '21 Years',
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
                           padding: const EdgeInsets.only(top: 5.0),
                           child: Container(
                             width: 343,
                             height: 20,
                             padding: const EdgeInsets.symmetric(horizontal: 12),
                             child: const Row(
                               mainAxisSize: MainAxisSize.min,
                               mainAxisAlignment: MainAxisAlignment.start,
                               crossAxisAlignment: CrossAxisAlignment.center,
                               children: [
                                 Expanded(
                                   child: SizedBox(
                                     child: Text(
                                       'Loan Eligibility',
                                       style: TextStyle(
                                         color: Color(0xFF1D2129),
                                         fontSize: 14,
                                         fontFamily: 'Nunito',
                                         fontWeight: FontWeight.w600,
                                         height: 0.11,
                                       ),
                                     ),
                                   ),
                                 ),
                                 SizedBox(width: 6),
                                 Text(
                                   ':',
                                   textAlign: TextAlign.center,
                                   style: TextStyle(
                                     color: Color(0xFF206CCF),
                                     fontSize: 14,
                                     fontFamily: 'Nunito',
                                     fontWeight: FontWeight.w700,
                                     height: 0.11,
                                   ),
                                 ),
                                 SizedBox(width: 6),
                                 Expanded(
                                   child: SizedBox(
                                     child: Text(
                                       'Not permissible',
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
                           padding: const EdgeInsets.only(top: 5.0),
                           child: Container(
                             width: 343,
                             height: 20,
                             padding: const EdgeInsets.symmetric(horizontal: 12),
                             child: const Row(
                               mainAxisSize: MainAxisSize.min,
                               mainAxisAlignment: MainAxisAlignment.start,
                               crossAxisAlignment: CrossAxisAlignment.center,
                               children: [
                                 Expanded(
                                   child: SizedBox(
                                     child: Text(
                                       'Withdrawal Option',
                                       style: TextStyle(
                                         color: Color(0xFF1D2129),
                                         fontSize: 14,
                                         fontFamily: 'Nunito',
                                         fontWeight: FontWeight.w600,
                                         height: 0.11,
                                       ),
                                     ),
                                   ),
                                 ),
                                 SizedBox(width: 6),
                                 Text(
                                   ':',
                                   textAlign: TextAlign.center,
                                   style: TextStyle(
                                     color: Color(0xFF206CCF),
                                     fontSize: 14,
                                     fontFamily: 'Nunito',
                                     fontWeight: FontWeight.w700,
                                     height: 0.11,
                                   ),
                                 ),
                                 SizedBox(width: 6),
                                 Expanded(
                                   child: SizedBox(
                                     child: Text(
                                       'Available at Age 18',
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
                           padding: const EdgeInsets.only(top: 5.0),
                           child: Container(
                             width: 343,
                             height: 20,
                             padding: const EdgeInsets.symmetric(horizontal: 12),
                             child: const Row(
                               mainAxisSize: MainAxisSize.min,
                               mainAxisAlignment: MainAxisAlignment.start,
                               crossAxisAlignment: CrossAxisAlignment.center,
                               children: [
                                 Expanded(
                                   child: SizedBox(
                                     child: Text(
                                       'Premature Closure',
                                       style: TextStyle(
                                         color: Color(0xFF1D2129),
                                         fontSize: 14,
                                         fontFamily: 'Nunito',
                                         fontWeight: FontWeight.w600,
                                         height: 0.11,
                                       ),
                                     ),
                                   ),
                                 ),
                                 SizedBox(width: 6),
                                 Text(
                                   ':',
                                   textAlign: TextAlign.center,
                                   style: TextStyle(
                                     color: Color(0xFF206CCF),
                                     fontSize: 14,
                                     fontFamily: 'Nunito',
                                     fontWeight: FontWeight.w700,
                                     height: 0.11,
                                   ),
                                 ),
                                 SizedBox(width: 6),
                                 Expanded(
                                   child: SizedBox(
                                     child: Text(
                                       'After 5 Years*',
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
                           padding: const EdgeInsets.only(top: 5.0,),
                           child: Container(
                             width: 343,
                             height: 20,
                             padding: const EdgeInsets.symmetric(horizontal: 12),
                             child:  Row(
                               mainAxisSize: MainAxisSize.min,
                               mainAxisAlignment: MainAxisAlignment.start,
                               crossAxisAlignment: CrossAxisAlignment.center,
                               children: [
                                 Expanded(
                                   child: SizedBox(
                                     child: Text(
                                       'Current Interest Rate',
                                       style: TextStyle(
                                         color: Color(0xFF1D2129),
                                         fontSize: 14,
                                         fontFamily: 'Nunito',
                                         fontWeight: FontWeight.w600,
                                         height: 0.11,
                                       ),
                                     ),
                                   ),
                                 ),
                                 SizedBox(width: 6),
                                 Text(
                                   ':',
                                   textAlign: TextAlign.center,
                                   style: TextStyle(
                                     color: Color(0xFF206CCF),
                                     fontSize: 14,
                                     fontFamily: 'Nunito',
                                     fontWeight: FontWeight.w700,
                                     height: 0.11,
                                   ),
                                 ),
                                 SizedBox(width: 6),
                                 Expanded(
                                   child: SizedBox(
                                     child: Text(
                                       '${interest}%',
                                       style: TextStyle(
                                         color: Color(0xFFF63031),
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
                     )
                    ],
                  ),
                )),

          ],
        ),
      ),
    );
  }
}
Widget Appbar(Widget icon){
  return AppBar(
    backgroundColor: Colors.white,
    elevation: 1,
    leading: Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: SvgPicture.asset(
        "assets/Images/Logo.svg",
      ),
    ),
    leadingWidth: 150,
    actions: [
      icon,

    ],
  );
}