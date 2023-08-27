import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:practice_application/login_data.dart';
import 'package:provider/provider.dart';

class PortraitLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double tempHeight = MediaQuery.of(context).size.height;
    double tempWidth = MediaQuery.of(context).size.width;
    double screenHeight =
        (MediaQuery.of(context).orientation == Orientation.portrait
            ? tempHeight
            : tempWidth);
    double screenWidth = tempWidth;
    BuildContext mainContext = context;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Color.fromARGB(244, 251, 180, 2),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          reverse: false,
          child: Container(
            padding: EdgeInsets.fromLTRB(screenWidth / 10, screenHeight / 25,
                screenWidth / 10, screenHeight / 25),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, screenHeight / 100),
                    alignment: Alignment.center,
                    child: CircleAvatar(
                        backgroundColor: Colors.black,
                        child: Image.asset('assets/logo.png'),
                        radius: (screenHeight / 12)),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, screenHeight / 20),
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      children: [
                        Container(
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
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, screenHeight / 400),
                    alignment: Alignment.centerLeft,
                    child: Column(
                      children: [
                        Container(
                          padding:
                              EdgeInsets.fromLTRB(screenWidth / 15, 0, 0, 0),
                          margin:
                              EdgeInsets.fromLTRB(0, 0, 0, screenHeight / 70),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Hoş geldiniz",
                            style: GoogleFonts.montserrat(
                                textStyle: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: screenHeight / 22)),
                            softWrap: true,
                            textAlign: TextAlign.start,
                          ),
                        ),
                        Container(
                          margin:
                              EdgeInsets.fromLTRB(0, 0, 0, screenHeight / 70),
                          height: screenHeight / 15,
                          width: screenWidth / 1.5,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(65, 255, 255, 255),
                            borderRadius:
                                BorderRadius.circular(screenHeight / 50),
                          ),
                          child: Consumer<LoginData>(
                            builder: (context, LoginData, child) {
                              return TextField(
                                controller: LoginData.emailTextController,
                                obscureText: false,
                                textAlign: TextAlign.left,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    prefixIcon: Icon(
                                      Icons.person_2_outlined,
                                      color: Colors.white,
                                    ),
                                    hintText: "kullanıcı adı/E-mail",
                                    hintStyle: TextStyle(
                                        fontSize: screenHeight / 50,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)),
                                style: TextStyle(
                                    fontSize: screenHeight / 50,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              );
                            },
                          ),
                        ),
                        Container(
                          height: screenHeight / 15,
                          width: screenWidth / 1.5,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(65, 255, 255, 255),
                            borderRadius:
                                BorderRadius.circular(screenHeight / 50),
                          ),
                          child: Consumer<LoginData>(
                              builder: (context, LoginData, child) {
                            return TextField(
                              controller: LoginData.passwordTextController,
                              textAlign: TextAlign.left,
                              obscureText: LoginData.isvisible,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                prefixIcon: Icon(
                                  Icons.lock_outline_rounded,
                                  color: Colors.white,
                                ),
                                hintText: "Şifre",
                                hintStyle: TextStyle(
                                    fontSize: screenHeight / 50,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                                suffixIcon: GestureDetector(
                                  child: Icon(
                                    Icons.visibility,
                                    color: Colors.white,
                                  ),
                                  onLongPressStart: (detail) {
                                    LoginData.changeVisibility();
                                  },
                                  onLongPressEnd: (detail) {
                                    LoginData.changeVisibility();
                                  },
                                ),
                              ),
                              style: TextStyle(
                                  fontSize: screenHeight / 50,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.fromLTRB(screenWidth / 15, 0, 0, 0),
                      margin: EdgeInsets.fromLTRB(
                          0, screenHeight / 50, 0, screenHeight / 50),
                      child: Row(
                        children: [
                          Consumer<LoginData>(
                              builder: (context, LoginData, child) {
                            return GestureDetector(
                              child: Container(
                                margin: EdgeInsets.fromLTRB(
                                    0, 0, screenWidth / 40, 0),
                                child: LoginData.checkIsClicked()
                                    ? Icon(Icons.check_box, color: Colors.white)
                                    : Icon(Icons.check_box_outline_blank,
                                        color: Colors.white),
                              ),
                              onTap: () {
                                LoginData.changeIsClicked();
                              },
                            );
                          }),
                          Text(
                            "Beni Hatırla",
                            style: GoogleFonts.montserrat(
                                textStyle: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: screenHeight / 40)),
                            softWrap: true,
                          ),
                        ],
                      )),
                  Consumer<LoginData>(builder: (context, LoginData, child) {
                    return Container(
                      width: screenWidth / 2,
                      clipBehavior: Clip.antiAlias,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                              color: Colors.white, width: screenWidth / 100),
                          borderRadius: BorderRadius.all(
                              Radius.circular(screenHeight / 50))),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.white,
                        ),
                        onPressed: () {
                          LoginData.signInWithEmailAndPassword(mainContext);
                        },
                        child: Container(
                            child: Text(
                          "Giriş Yap",
                          style: GoogleFonts.montserrat(
                              textStyle: TextStyle(
                                  color: Color.fromARGB(244, 251, 180, 2),
                                  fontWeight: FontWeight.w700,
                                  fontSize: screenHeight / 40)),
                          softWrap: true,
                        )),
                      ),
                    );
                  }),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, screenHeight / 60, 0, 0),
                    alignment: Alignment.center,
                    child: GestureDetector(
                      child: Text(
                        "Şifremi Unuttum",
                        style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: screenHeight / 40)),
                        softWrap: true,
                      ),
                      onTap: () async {
                        await Navigator.pushNamed(context, '/forgotpassword');
                      },
                    ),
                  )
                ]),
          ),
        ),
      ),
    );
    // This trailing comma makes auto-formatting nicer for build methods.
  }
}
