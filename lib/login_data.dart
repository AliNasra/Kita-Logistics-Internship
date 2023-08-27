import 'dart:convert';
import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'auth.dart';

class LoginData extends ChangeNotifier {
  final DatabaseReference employeeRef = FirebaseDatabase.instance
      .ref()
      .child("employee"); // Reference for the employee table in the database
  bool isvisible =
      true; // Obscures or the visualizes the text in the password textfield
  bool isclicked = false; // Checking if the visibility icon is clicked
  final emailTextController =
      TextEditingController(); // For the input coming from the email text controller in the login page
  final passwordTextController =
      TextEditingController(); // For the input coming from the password text controller in the login page
  final forgotEmailEmailTextController =
      TextEditingController(); // For the input coming from the email text controller in the forgot password page
  String employeeName =
      ""; // Its constituents, name and surname, are fetched from the database
  String employeePosition = ""; // Fetched from the database
  var profileImage; // Fetched from the database as a encoded string sequence
  String userID = ""; // Fetched from the database

  ///Fetch from the database the string that denotes the image based on the email used by the user while logging in
  Future<void> initializeImage() async {
    //print("Employee's name is ${employeeName}");
    String email = emailTextController.text.trim();
    Query query = employeeRef.orderByChild("email").equalTo(email);
    DataSnapshot event = await query.get();
    Map<dynamic, dynamic> employee = event.value as Map<dynamic, dynamic>;
    userID = employee.keys.first;
    Map<dynamic, dynamic> employeeInfo = employee[userID];
    employeeName = "${employeeInfo["firstName"]} ${employeeInfo["lastName"]}";
    employeePosition = employeeInfo["position"];
    if (employeeInfo["image"] == "") {
      ByteData bytes = await rootBundle.load('assets/logo.png');
      var buffer = bytes.buffer;
      var encoding = base64.encode(Uint8List.view(buffer));
      profileImage = base64Decode(encoding);
    } else {
      profileImage = base64Decode(employeeInfo["image"]);
    }
  }

  /////Return a dialog informing the user of erroneous input due to potential data mismatch
  void ReturnSignInError(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Hata"),
            content: emailTextController.text.trim() == ''
                ? Text("Email hanesini boş bırakmayın.")
                : Text("Girdiğiniz email kaydı bulunmamaktadır."),
            actions: [
              TextButton(
                child: Text("Tamam"),
                onPressed: () {
                  Navigator.pop(context, true);
                },
              )
            ],
          );
        });
  }

  /////Return a dialog informing the user of erroneous input due to potential data mismatch while typing their email
  void ReturnResetEmailError(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Hata"),
            content: forgotEmailEmailTextController.text.trim() == ''
                ? Text("Email hanesini boş bırakmayın.")
                : Text("Girdiğiniz email kaydı bulunmamaktadır."),
            actions: [
              TextButton(
                child: Text("Tamam"),
                onPressed: () {
                  Navigator.pop(context, true);
                },
              )
            ],
          );
        });
  }

  //Signing in using Firebase Authorization Mechanism
  Future<void> signInWithEmailAndPassword(BuildContext context) async {
    try {
      if (RegExp("([a-z]+\.[a-z]+\@kitalogistics\.com)")
          .hasMatch(emailTextController.text.trim())) {
        await initializeImage();
        await Auth().signInWithEmailAndPassword(
            email: emailTextController.text.trim(),
            password: passwordTextController.text.trim());
      } else {
        ReturnSignInError(context);
      }
    } on FirebaseAuthException catch (_) {
      ReturnSignInError(context);
    }
  }

  //Reset the password with Firebase Authorization
  Future<void> sendResetPassEmail(BuildContext context) async {
    try {
      if (RegExp("([a-z]+\.[a-z]+\@kitalogistics\.com)")
          .hasMatch(forgotEmailEmailTextController.text.trim())) {
        await Auth().sendResetPasswordEmail(
            email: forgotEmailEmailTextController.text.trim());
      } else {
        ReturnResetEmailError(context);
      }
    } on FirebaseAuthException catch (_) {
      ReturnResetEmailError(context);
    }
  }

  //Change the visibility of the password text field
  void changeVisibility() {
    isvisible = !isvisible;
    notifyListeners();
  }

  void changeIsClicked() {
    isvisible = !isvisible;
    notifyListeners();
  }

  bool checkIsClicked() {
    return isclicked;
  }

  // Change the image in the database based on the user's input
  Future<void> setImage(String newImageVal) async {
    profileImage = base64Decode(newImageVal);
    await employeeRef.child(userID).update({'image': newImageVal});
  }
  /**
  // Storing some variables the the state of the home page
  void setLoginDataInitalizers(String employeeName, String employeePosition,
      var profileImage, String userID) {
    //print("Employee Name is ${employeeName}");
    this.employeeName = employeeName;
    this.employeePosition = employeePosition;
    this.profileImage = profileImage;
    this.userID = userID;
  }
   */
}
