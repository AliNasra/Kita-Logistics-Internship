import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:practice_application/login_data.dart';
import 'package:provider/provider.dart';

class forgotPassword extends StatelessWidget {
  Widget build(BuildContext context) {
    double screenHeight = 0;
    double screenWidth = 0;
    BuildContext mainContext = context;
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Color.fromARGB(244, 251, 180, 2),
        body: SingleChildScrollView(
          reverse: false,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(0, screenHeight / 25, 0, 0),
                margin: EdgeInsets.fromLTRB(0, 0, 0, screenHeight / 50),
                child: Row(
                  children: [
                    GestureDetector(
                      child: Container(
                          margin:
                              EdgeInsets.fromLTRB(0, 0, screenWidth / 3.85, 0),
                          alignment: Alignment.topCenter,
                          child: Icon(Icons.arrow_back_outlined,
                              size: screenHeight / 20)),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    Container(
                      alignment: Alignment.topCenter,
                      child: CircleAvatar(
                          backgroundColor: Colors.black,
                          child: Image.asset('assets/logo.png'),
                          radius: (screenHeight / 10)),
                    ),
                  ],
                ),
              ),
              Container(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, screenHeight / 35),
                        child: Text(
                          "KITA\nLOGISTICS\nSALES APP",
                          style: GoogleFonts.montserrat(
                              textStyle: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                  fontSize: screenHeight / 20)),
                          softWrap: true,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(
                            screenWidth / 10, screenHeight / 20, 0, 0),
                        width: screenWidth,
                        height: screenHeight / 1.9,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                              color: Colors.white, width: screenWidth / 100),
                          borderRadius: BorderRadius.vertical(
                              top: Radius.circular(screenHeight / 20),
                              bottom: Radius.circular(screenHeight / 50)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              spreadRadius: screenHeight / 50,
                              blurRadius: screenHeight / 50,
                              offset:
                                  Offset(0, 1), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(
                                  0, screenHeight / 20, 0, screenHeight / 20),
                              child: Text(
                                "Şifremi Unuttum",
                                style: GoogleFonts.montserrat(
                                    textStyle: TextStyle(
                                        color: Color.fromARGB(244, 251, 180, 2),
                                        fontWeight: FontWeight.w900,
                                        fontSize: screenHeight / 25)),
                                softWrap: true,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(
                                  0, 0, 0, screenHeight / 20),
                              alignment: Alignment.topLeft,
                              padding: EdgeInsets.fromLTRB(
                                  0, screenHeight / 100, 0, 0),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.white,
                                      width: screenWidth / 100),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(screenHeight / 40))),
                              height: screenHeight / 20,
                              width: screenWidth / 1.2,
                              child: Consumer<LoginData>(
                                  builder: (context, LoginData, child) {
                                return TextField(
                                  controller:
                                      LoginData.forgotEmailEmailTextController,
                                  obscureText: false,
                                  textAlign: TextAlign.left,
                                  decoration: InputDecoration(
                                    hintText: "Email",
                                  ),
                                  style: TextStyle(
                                      fontSize: screenHeight / 50,
                                      color: Color.fromRGBO(0, 0, 0, 1),
                                      fontWeight: FontWeight.bold),
                                );
                              }),
                            ),
                            Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Color.fromARGB(244, 251, 180, 2),
                                        width: screenHeight / 100),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(screenHeight / 40))),
                                height: screenHeight / 15,
                                width: screenWidth / 1.2,
                                child: Consumer<LoginData>(
                                    builder: (context, LoginData, child) {
                                  return TextButton(
                                    style: TextButton.styleFrom(
                                      backgroundColor:
                                          Color.fromARGB(245, 249, 165, 8),
                                    ),
                                    onPressed: () {
                                      LoginData.sendResetPassEmail(mainContext);
                                    },
                                    child: Text(
                                      "Gönder",
                                      style: GoogleFonts.quicksand(
                                          textStyle: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700,
                                              fontSize: screenHeight / 40)),
                                      softWrap: true,
                                    ),
                                  );
                                })),
                          ],
                        ),
                      ),
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
    // This trailing comma makes auto-formatting nicer for build methods.
  }
}
