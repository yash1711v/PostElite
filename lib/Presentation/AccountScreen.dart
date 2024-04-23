import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'home_screen.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(40,60), child: Appbar(Padding(
        padding: const EdgeInsets.only(right: 20.0),
        child: SvgPicture.asset(
          "assets/Images/Account.svg",
          width: 24,
          height: 24,
        ),
      )),

      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: Color(0x7F86909C)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 90,

              clipBehavior: Clip.antiAlias,
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                shadows: [
                  BoxShadow(
                    color: Color(0x07101828),
                    blurRadius: 8,
                    offset: Offset(0, 8),
                    spreadRadius: -4,
                  ),BoxShadow(
                    color: Color(0x14101828),
                    blurRadius: 24,
                    offset: Offset(0, 20),
                    spreadRadius: -4,
                  )
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                    ],
                  ),
                  Container(
                    width: double.infinity,
                    height: 40,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset("assets/Images/sukaniyaAletrLogo.svg",
                            color: Colors.red,),
                          ],
                        ),
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 311,
                              child: Text(
                                'Accounts not yet added!',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFF1D2129),
                                  fontSize: 20,
                                  fontFamily: 'Nunito',
                                  fontWeight: FontWeight.w700,
                                  height: 0.05,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
