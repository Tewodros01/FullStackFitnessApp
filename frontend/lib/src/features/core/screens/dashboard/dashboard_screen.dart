import 'package:flutter/material.dart';
import 'package:frontend/src/constants/colors.dart';
import 'package:frontend/src/features/core/screens/book/book_screen.dart';
import 'package:frontend/src/features/core/screens/home/home_page.dart';
import 'package:frontend/src/features/core/screens/profile/profile_screen.dart';
import 'package:frontend/src/features/core/screens/workout_plan/workout_plan_screen.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  final List<Widget> _pageList = [
    const HomeScreen(),
    const BookScreen(),
    const WorkoutPlanScreen(),
    const ProfileScreen(),
  ];
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pageList[selectedIndex],
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(40)),
        child: BottomNavigationBar(
          iconSize: 30,
          type: BottomNavigationBarType.fixed,
          elevation: 8,
          currentIndex: selectedIndex,
          backgroundColor: Colors.white,
          selectedItemColor: cDarkGrey,
          onTap: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
          selectedIconTheme: const IconThemeData(
            color: cSecondaryColor,
          ),
          unselectedIconTheme: const IconThemeData(
            color: Colors.black12,
          ),
          items: const [
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: Icon(Icons.home),
              ),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: Icon(Icons.book),
              ),
              label: "Book",
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: Icon(Icons.fitness_center),
              ),
              label: "Excercise",
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: Icon(Icons.person),
              ),
              label: "Profile",
            ),
          ],
        ),
      ),
    );
  }
}
