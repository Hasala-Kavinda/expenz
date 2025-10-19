import 'package:expenz/screens/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferences.getInstance();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Expanz", 
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: "Inter",
        ),
        home: const OnBoardingScreen());
  }
}
