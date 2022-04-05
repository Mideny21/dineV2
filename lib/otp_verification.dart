import 'package:flutter/material.dart';

class OtpVerification extends StatefulWidget {
  OtpVerification({Key? key, number, otp}) : super(key: key);
  String? number;
  String? otp;

  @override
  State<OtpVerification> createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Verification")),
      body: Center(child: Text("Nice")),
    );
  }
}
