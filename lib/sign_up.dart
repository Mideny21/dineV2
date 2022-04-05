import 'dart:async';

import 'package:dine_app/otp_verification.dart';
import 'package:dine_app/pin.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SignUp extends StatefulWidget {
  SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool _toggleVisibility = true;
  // final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final _lastname = TextEditingController();

  final _fistname = TextEditingController();

  // final _email = TextEditingController();

  final _phone = TextEditingController();

  final _password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _dio = Dio();

  _sendData(BuildContext context) async {
    try {
      _dio.options.headers['Content-type'] = 'application/json';
      // dio.options.headers['Authorization'] = authorization;
      final response = await _dio.post(
        "http://localhost:3001/api/user/signup",
        data: {
          "number": _phone.text,
          "password": _password.text,
          "firstName": _fistname.text,
          "lastName": _lastname.text
        },
      );
      if (response.statusCode == 200) {
        // Navigator.pop(context);
        // print("THE OTP IS ${response.data['otp']}");
        var otpValue = response.data['otp'];
        print(otpValue);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (builder) =>
                    PinCodeVerificationScreen(_phone.text, otpValue)));
        // Timer(Duration(seconds: 2), () {
        //   Navigator.of(context).pushReplacementNamed('/Pages', arguments: 2);
        // });
      } else {
        // Navigator.pop(context);
        SnackBar(
          content: Text('There is error please try again later'),
        );
      }
      // print(response.data);
    } on DioError catch (e) {
      print(e.response);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Sign Up")),
        body: SingleChildScrollView(
          child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 28.0, top: 14.0, right: 28.0, bottom: 8.0),
                    child: TextFormField(
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        labelText: 'Phone number',
                        errorBorder: UnderlineInputBorder(),
                        focusedErrorBorder: UnderlineInputBorder(),
                        contentPadding: EdgeInsets.all(12.0),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                        labelStyle: TextStyle(
                          color: Colors.black54,
                        ),
                        suffixIcon: Icon(
                          Icons.check_circle,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                      ),
                      controller: _phone,
                      validator: (String? value) {
                        // if (value.trim().length <= 0) {
                        if (value!.isEmpty ||
                            !RegExp(r'^(?:[+0]9)?[0-9]{10}$').hasMatch(value)) {
                          return 'Phone is required and should be a number.';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 28.0, top: 14.0, right: 28.0, bottom: 8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        labelText: 'Password',
                        filled: true,
                        errorBorder: UnderlineInputBorder(),
                        focusedErrorBorder: UnderlineInputBorder(),
                        contentPadding: EdgeInsets.all(12.0),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                        labelStyle: TextStyle(
                          color: Colors.black54,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        suffixIcon: IconButton(
                            icon: _toggleVisibility
                                ? Icon(Icons.visibility_off)
                                : Icon(Icons.visibility),
                            onPressed: () {
                              setState(() {
                                _toggleVisibility = !_toggleVisibility;
                              });
                            }),
                      ),
                      obscureText: _toggleVisibility,
                      controller: _password,
                      // validator: (String? value) {
                      //   if (value!.isEmpty || value.length < 6) {
                      //     return 'Password invalid';
                      //   }
                      //   return null;
                      // },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 28.0, top: 14.0, right: 28.0, bottom: 8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        labelText: 'First name',
                        filled: true,
                        errorBorder: UnderlineInputBorder(),
                        focusedErrorBorder: UnderlineInputBorder(),
                        contentPadding: EdgeInsets.all(12.0),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                        labelStyle: TextStyle(
                          color: Colors.black54,
                        ),
                        suffixIcon: Icon(
                          Icons.check_circle,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                      ),
                      controller: _fistname,
                      keyboardType: TextInputType.name,
                      validator: (String? value) {
                        if (value!.isEmpty || value.length < 3) {
                          return 'first name is required and should be 3+ characters long.';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 28.0, top: 14.0, right: 28.0, bottom: 8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        labelText: 'Last name',
                        filled: true,
                        errorBorder: UnderlineInputBorder(),
                        focusedErrorBorder: UnderlineInputBorder(),
                        contentPadding: EdgeInsets.all(12.0),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                        labelStyle: TextStyle(
                          color: Colors.black54,
                        ),
                        suffixIcon: Icon(
                          Icons.check_circle,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                      ),
                      controller: _lastname,
                      keyboardType: TextInputType.name,
                      validator: (String? value) {
                        if (value!.isEmpty || value.length < 3) {
                          return 'last name is required and should be 3+ characters long.';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 30),
                  Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      decoration: BoxDecoration(
                          color: Colors.yellow,
                          borderRadius: BorderRadius.circular(100)),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: InkWell(
                          onTap: () {
                            _sendData(context);
                          },
                          child: const Center(
                            child: Text(
                              "LOGIN",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      )),
                ],
              )),
        ));
  }
}
