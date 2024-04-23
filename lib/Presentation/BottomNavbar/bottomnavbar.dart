import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';

class BottomNavBar extends StatefulWidget {
  PageController pageController;
   BottomNavBar({super.key,required this.pageController});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int selectedIndex=0;
  @override
  Widget build(BuildContext context) {
    return WaterDropNavBar(
      bottomPadding: 20,
      waterDropColor: Colors.blue,
      backgroundColor: Colors.white,
      onItemSelected: (index) {

        setState(() {
          selectedIndex = index;
        });

        widget.pageController.animateToPage(selectedIndex, duration: const Duration(milliseconds: 400), curve: Curves.easeOutQuad);


      },
      selectedIndex: selectedIndex,
      barItems: [
        BarItem(
          filledIcon: Icons.home_rounded,
          outlinedIcon: Icons.home_outlined,
        ),
        BarItem(
            filledIcon: Icons.people_rounded,
            outlinedIcon: Icons.people_alt_outlined),
        BarItem(
            filledIcon: Icons.person_pin_rounded,
            outlinedIcon: Icons.person_pin_circle_outlined),
      ],
    );
  }
}
