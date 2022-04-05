import 'package:dine_app/pin.dart';
import 'package:flutter/material.dart';

import 'sign_up.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Authentication',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SignUp());
  }
}
