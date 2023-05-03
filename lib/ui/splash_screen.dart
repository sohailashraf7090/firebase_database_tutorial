import 'package:firebase_database_tutorial/firebase_services/firebase_services.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  FireBaseServices splashScreen = FireBaseServices();
  @override
  void initState() {
    super.initState();
    splashScreen.isLogin(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[500],
      body: const Center(
          child: Text(
        "Splash Screen",
        style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
      )),
    );
  }
}
