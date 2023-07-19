import 'package:flutter/material.dart';
//import 'package:practice_application/info_widget.dart';
//import 'header_widget.dart';
//import 'password_widget.dart';
import 'specifications.dart';
//import 'email_widget.dart';
//import 'forgot_password_widget.dart';
//import 'sign_in_widget.dart';
import 'package:crypt/crypt.dart';
import 'package:email_validator/email_validator.dart';

class PortraitLogin extends StatefulWidget {
  const PortraitLogin({super.key});

  @override
  State<PortraitLogin> createState() => PortraitLoginState();
}

class PortraitLoginState extends State<PortraitLogin> {
  bool _isvisible = true;
  String password_string = '';
  String hashed_password_string = '';
  String email_validation_message = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            backgroundColor: colorBlack,
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    Image.asset('assets/logo.png', height: 100, width: 100),
                  ]),
                  Container(
                      padding: const EdgeInsets.all(5),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "LOGIN",
                            style: TextStyle(
                                color: colorWhite,
                                fontWeight: FontWeight.bold,
                                fontSize: 30),
                          ),
                          SizedBox(height: 10),
                          Text("Kindly Insert Your Credentials Correctly!",
                              style: TextStyle(
                                  color: colorWhite,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20)),
                        ],
                      )),
                  SizedBox(height: 10),
                  SizedBox(
                      width: 300,
                      child: TextField(
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              color: Color.fromARGB(243, 255, 255, 255),
                              width: 3,
                            ),
                          ),
                          hintText: 'Enter your email',
                          hintStyle: TextStyle(color: colorWhite, fontSize: 20),
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                          suffixIcon: IconButton(
                            icon: Icon(Icons.email_rounded),
                            onPressed: () {},
                          ),
                        ),
                        style: TextStyle(
                            fontSize: 15,
                            color: colorWhite,
                            fontWeight: FontWeight.bold),
                      onChanged: (text){
                        //setState() {
                        bool isValid = EmailValidator.validate(text);
                        if (isValid){                      
                          email_validation_message = "Email is correct";                      
                        }
                        else{
                          email_validation_message = "The email isn't valid. Please check the input";
                          
                        }
                        //}
                      },),
                       ),
                  SizedBox(height: 20),
                  SizedBox(
                      width: 300,
                      child: TextField(
                        obscureText: _isvisible,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              color: Color.fromARGB(243, 255, 255, 255),
                              width: 3,
                            ),
                          ),
                          hintText: 'Enter your password',
                          hintStyle: TextStyle(color: colorWhite, fontSize: 20),
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                          suffixIcon: IconButton(
                            icon: _isvisible
                                ? Icon(Icons.visibility)
                                : Icon(Icons.visibility_off),
                            onPressed: () {
                              setState(() {
                                _isvisible = !_isvisible;
                              });
                            },
                          ),
                        ),
                        style: TextStyle(
                            fontSize: 20,
                            color: colorWhite,
                            fontWeight: FontWeight.bold),
                        onChanged: (text) {
                          //setState(text){
                          password_string = text;
                          hashed_password_string =
                              Crypt.sha256(password_string, rounds: 10000)
                                  .toString();
                          //}
                        },
                      )),
                  SizedBox(height: 5),
                  Text(
                    "Forgot your password?",
                    style: TextStyle(
                        color: colorGrey,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                      height: 50,
                      width: 150,
                      child: TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.yellowAccent[700],
                          ),
                          onPressed: () {},
                          child: const Text(
                            'Sign in',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w700),
                          ))),
                  SizedBox(height: 5),
                  Container(
                    height: 150,
                    width: 400,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Hashed Password is:",
                            style: TextStyle(
                                color: colorGrey,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                          TextField(
                            maxLines: 3,
                            enabled: false,
                            controller: TextEditingController(
                                text: hashed_password_string),
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                  color: Color.fromARGB(243, 255, 255, 255),
                                  width: 3,
                                ),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 15),
                            ),
                            style: TextStyle(
                                fontSize: 15,
                                color: colorWhite,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Email Validation Result:",
                            style: TextStyle(
                                color: colorGrey,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                          Container(
                            height: 40,
                            child: TextField(
                              maxLines: 3,
                              enabled: false,
                              controller: TextEditingController(
                                  text: email_validation_message),
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(
                                    color: Color.fromARGB(243, 255, 255, 255),
                                    width: 3,
                                  ),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 15),
                              ),
                              style: TextStyle(
                                  fontSize: 15,
                                  color: colorWhite,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ]),
                  )
                ],
              ),
            )
            // This trailing comma makes auto-formatting nicer for build methods.
            ));
  }
}
