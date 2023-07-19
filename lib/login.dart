import 'package:flutter/material.dart';
//import 'package:crypt/crypt.dart';
//import 'package:email_validator/email_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'auth.dart';

class PortraitLogin extends StatefulWidget {
  const PortraitLogin({super.key});

  @override
  State<PortraitLogin> createState() => PortraitLoginState();
}

class PortraitLoginState extends State<PortraitLogin> {
  bool _isvisible = true;
  bool _isclicked = false;
  String password_string = '';
  String hashed_password_string = '';
  String? error_text = '';
  double screenHeight = 0;
  double screenWidth = 0;
  //bool _isloggedIn = false;
  //bool _isEmailValid = false;
  //bool _emailPassMatch = false;
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  var database = FirebaseFirestore.instance.collection("employees");

  Future<void> signInWithEmailAndPassword() async {
    try {
      await Auth().signInWithEmailAndPassword(
          email: emailTextController.text,
          password: passwordTextController.text);
    } on FirebaseAuthException catch (_) {
      showDialog(
        //if set to true allow to close popup by tapping out of the popup
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text("Hata"),
          content: Text("Girdiğiniz bilgiler hatalıdır."),
          actions: [
            TextButton(
              child: Text("Tamam"),
              onPressed: () {
                Navigator.pop(context, true);
              },
            ),
          ],
        ),
      );
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: Container(
          padding: EdgeInsets.fromLTRB(screenWidth / 10, screenHeight / 10,
              screenWidth / 10, screenHeight / 10),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Container(
              height: screenHeight / 4,
              alignment: Alignment.topCenter,
              child: CircleAvatar(
                  backgroundColor: Colors.black,
                  child: Image.asset('assets/logo.png'),
                  radius: (screenHeight / 12)),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, screenHeight / 90),
              alignment: Alignment.bottomLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Giriş Yap",
                        style: GoogleFonts.quicksand(
                            textStyle: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: screenHeight / 30)),
                        softWrap: true,
                      ),
                      Text(
                        "Kita Logistics is an integrated logistics company, established in 1995",
                        style: GoogleFonts.quicksand(
                            textStyle: TextStyle(
                                color: Color.fromARGB(225, 0, 0, 0),
                                fontWeight: FontWeight.w700,
                                fontSize: screenHeight / 50)),
                        softWrap: true,
                      )
                    ],
                  )),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, screenHeight / 400),
              alignment: Alignment.topLeft,
              child: Text(
                "Email/ Kulanıcı Kodu",
                style: GoogleFonts.quicksand(
                    textStyle: TextStyle(
                        color: Color.fromARGB(252, 216, 141, 3),
                        fontWeight: FontWeight.w700,
                        fontSize: screenHeight / 50)),
                softWrap: true,
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, screenHeight / 200),
              alignment: Alignment.topLeft,
              padding: EdgeInsets.fromLTRB(0, screenHeight / 100, 0, 0),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.black,
                    width: 1.0,
                  ),
                ),
              ),
              height: screenHeight / 20,
              width: screenWidth / 1.2,
              child: TextField(
                controller: emailTextController,
                obscureText: false,
                textAlign: TextAlign.left,
                decoration: InputDecoration(
                  hintText: "example@kitalogistics.com",
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      style: BorderStyle.solid,
                      color: Color.fromARGB(0, 0, 0, 0),
                      width: 5,
                    ),
                  ),
                ),
                style: TextStyle(
                    fontSize: screenHeight / 50,
                    color: Color.fromRGBO(0, 0, 0, 1),
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, screenHeight / 400),
              alignment: Alignment.centerLeft,
              child: Text(
                "Şifre",
                style: GoogleFonts.quicksand(
                    textStyle: TextStyle(
                        color: Color.fromARGB(252, 216, 141, 3),
                        fontWeight: FontWeight.w700,
                        fontSize: screenHeight / 50)),
                softWrap: true,
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, screenHeight / 200),
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                  border: Border(
                bottom: BorderSide(
                  color: Colors.black,
                  width: 1.0,
                ),
              )),
              height: screenHeight / 20,
              width: screenWidth / 1.2,
              child: TextField(
                controller: passwordTextController,
                textAlign: TextAlign.left,
                obscureText: _isvisible,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      style: BorderStyle.solid,
                      color: Color.fromARGB(0, 0, 0, 0),
                      width: 5,
                    ),
                  ),
                  suffixIcon: GestureDetector(
                    child: Icon(
                      Icons.visibility,
                      color: Color.fromARGB(231, 240, 180, 16),
                    ),
                    onLongPressStart: (detail) {
                      _isvisible = !_isvisible;
                      setState(() {});
                    },
                    onLongPressEnd: (detail) {
                      _isvisible = !_isvisible;
                      setState(() {});
                    },
                  ),
                ),
                style: TextStyle(
                    fontSize: screenHeight / 50,
                    color: const Color.fromARGB(255, 0, 0, 0),
                    fontWeight: FontWeight.bold),
                onChanged: (text) {
                  //bool isValid = EmailValidator.validate(text);
                },
              ),
            ),
            Container(
                height: screenHeight / 10,
                width: screenWidth / 1.2,
                child: Row(
                  children: [
                    GestureDetector(
                      child: Container(
                        margin: EdgeInsets.fromLTRB(0, 0, screenWidth / 100, 0),
                        child: _isclicked
                            ? Icon(Icons.check_box)
                            : Icon(Icons.check_box_outline_blank),
                      ),
                      onTap: () {
                        _isclicked = !_isclicked;
                        setState(() {});
                      },
                    ),
                    Text(
                      "Beni Hatırla",
                      style: GoogleFonts.quicksand(
                          textStyle: TextStyle(
                              color: Color.fromARGB(252, 216, 141, 3),
                              fontWeight: FontWeight.w700,
                              fontSize: screenHeight / 40)),
                      softWrap: true,
                    ),
                  ],
                )),
            SizedBox(
              height: screenHeight / 15,
              width: screenWidth / 1.4,
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Color.fromARGB(245, 249, 165, 8),
                ),
                onPressed: () {
                  //_isEmailValid = RegExp("([a-z]+\.[a-z]+\@kitalogistics\.com)")
                  //    .hasMatch(emailTextController.text);

                  signInWithEmailAndPassword();
                  setState() {}
                },
                child: Text(
                  "Giriş Yap",
                  style: GoogleFonts.quicksand(
                      textStyle: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontWeight: FontWeight.w700,
                          fontSize: screenHeight / 40)),
                  softWrap: true,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, screenHeight / 60, 0, 0),
              alignment: Alignment.center,
              child: Text(
                "Şifremi Unuttum",
                style: GoogleFonts.quicksand(
                    textStyle: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontWeight: FontWeight.w700,
                        fontSize: screenHeight / 40)),
                softWrap: true,
              ),
            )
          ]),
        ),
      ),
    );
    // This trailing comma makes auto-formatting nicer for build methods.
  }
}
