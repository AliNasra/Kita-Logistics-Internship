import 'package:flutter/material.dart';
import 'specifications.dart';

class LandscapeLogin extends StatefulWidget {
  const LandscapeLogin({super.key});

  @override
  State<LandscapeLogin> createState() => LandscapeLoginState();
}

class LandscapeLoginState extends State<LandscapeLogin> {
  bool _isvisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 200,
              width: 200,
              child: Image.asset("assets/logo.png", height: 400, width: 400),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 50,
                ),
                Text(
                  "LOGIN",
                  style: TextStyle(
                      color: colorWhite,
                      fontWeight: FontWeight.bold,
                      fontSize: 36),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 400,
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
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                    width: 400,
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
                    )),
                SizedBox(height: 20),
                Text(
                  "Forgot your password?",
                  style: TextStyle(
                      color: colorGrey,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                    height: 50,
                    width: 150,
                    child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.yellowAccent[700],
                        ),
                        onPressed: () {},
                        child: Text(
                          'Sign in',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w700),
                        ))),
              ],
            )
          ],
        ),
      ),
    );
  }
}
