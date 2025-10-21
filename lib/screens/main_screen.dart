import 'package:expenz/constants/colors.dart';
import 'package:expenz/screens/add_new_screen.dart';
import 'package:expenz/screens/budget_screen.dart';
import 'package:expenz/screens/home_screen.dart';
import 'package:expenz/screens/profle_screeen.dart';
import 'package:expenz/screens/transaction_screen.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentPageInex = 0;
  @override
  Widget build(BuildContext context) {
    // curent page index

    // Screen list
    final List<Widget> pages = [
      HomeScreen(),
      TransactionScreen(),
      AddNewScreen(),
      BudgetScreen(),
      ProfileScreen(),
    ];
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: kWhite,
          selectedItemColor: kMainColor,
          unselectedItemColor: kGrey,
          onTap: (index) {
            setState(() {
              _currentPageInex = index;
            });
          },
          currentIndex: _currentPageInex,
          selectedLabelStyle: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
          items: [
            const BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                ),
                label: "Home"),
            const BottomNavigationBarItem(
                icon: Icon(
                  Icons.list_rounded,
                ),
                label: "Transactions"),
            BottomNavigationBarItem(
              icon: Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                    color: kMainColor, shape: BoxShape.circle),
                child: const Icon(
                  Icons.add,
                  color: kWhite,
                  size: 30,
                ),
              ),
              label: "",
            ),
            const BottomNavigationBarItem(
                icon: Icon(
                  Icons.rocket,
                ),
                label: "Budget"),
            const BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                ),
                label: "Profile"),
          ]),
      body: pages[_currentPageInex],
    );
  }
}
