import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:post_elite/Presentation/AccountScreen.dart';
import 'package:post_elite/Presentation/Profile.dart';
import 'package:post_elite/Presentation/home_screen.dart';

import 'BottomNavbar/bottomnavbar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: pageController,
        children: [
          HomeScreen(),
          AccountScreen(),
          Profile(),
        ],
      ),
      bottomNavigationBar: BottomNavBar(pageController: pageController,),
    );
  }
}
