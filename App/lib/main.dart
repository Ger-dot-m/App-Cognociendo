import 'package:flutter/material.dart';
import 'User/Login.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: LoginPage());
  }
}

// flutter run --no-sound-null-safety
