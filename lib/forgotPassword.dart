import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class forgotPassword extends StatefulWidget {
  const forgotPassword({super.key});

  @override
  State<forgotPassword> createState() => forgotPasswordState();
}

class forgotPasswordState extends State<forgotPassword> {
  double screenHeight = 0;
  double screenWidth = 0;
  final emailTextController = TextEditingController();

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
              margin: EdgeInsets.fromLTRB(0, 0, 0, screenHeight/25),
              alignment: Alignment.topCenter,
              child: CircleAvatar(
                  backgroundColor: Colors.black,
                  child: Image.asset('assets/logo.png'),
                  radius: (screenHeight / 12)),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, screenHeight/8),
              child: Text(
                "Şifremi Unuttum",
                style: GoogleFonts.quicksand(
                    textStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: screenHeight / 30)),
                softWrap: true,
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, screenHeight / 50),
              alignment: Alignment.center,
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
              margin: EdgeInsets.fromLTRB(0, 0, 0, screenHeight / 50),
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
                  setState() {}
                },
                child: Text(
                  "Şifreyi Gönder",
                  style: GoogleFonts.quicksand(
                      textStyle: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontWeight: FontWeight.w700,
                          fontSize: screenHeight / 40)),
                  softWrap: true,
                ),
              ),
            ),
          ]),
        ),
      ),
    );
    // This trailing comma makes auto-formatting nicer for build methods.
  }
}
