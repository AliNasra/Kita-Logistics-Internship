import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'auth.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> {
  Future<void> signout() async {
    try {
      await Auth().signout();
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

  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 100,
        width: 200,
        child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: Color.fromARGB(245, 249, 165, 8),
          ),
          onPressed: () {
            //_isEmailValid = RegExp("([a-z]+\.[a-z]+\@kitalogistics\.com)")
            //    .hasMatch(emailTextController.text);
    
            signout();
            setState() {}
          },
          child: Text(
            "Çıkış Yap",
            style: GoogleFonts.quicksand(
                textStyle: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontWeight: FontWeight.w700,
                    fontSize:  30)),
            softWrap: true,
          ),
        ),
      ),
    );
  }
}
