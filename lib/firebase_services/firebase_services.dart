import 'dart:async';

import 'package:firebase_database_tutorial/ui/authntication/login_screen.dart';

import 'package:flutter/material.dart';

class FireBaseServices {
  void isLogin(BuildContext context) {
    Timer(
        const Duration(seconds: 2),
        () => Navigator.push(context,
            MaterialPageRoute(builder: (context) => const LoginScreen())));
  }
}
