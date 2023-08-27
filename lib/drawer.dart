import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'auth.dart';
import 'package:provider/provider.dart';
import 'login_data.dart';

class MainDrawer extends StatefulWidget {
  double screenHeight;
  double screenWidth;
  BuildContext callerContext;
  MainDrawer(this.screenHeight, this.screenWidth, this.callerContext);
  @override
  MainDrawerState createState() => MainDrawerState();
}

class MainDrawerState extends State<MainDrawer> {
  Future<void> signout() async {
    try {
      await Auth().signout();
      Navigator.popUntil(context, ModalRoute.withName("/"));
    } on FirebaseAuthException catch (_) {
      showDialog(
        //if set to true allow to close popup by tapping out of the popup
        barrierDismissible: false,
        context: widget.callerContext,
        builder: (BuildContext context) => AlertDialog(
          title: Text("Hata"),
          content: Text("Bir hata oluştu. Lütfen tekrar deneyin"),
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
    return Drawer(
        backgroundColor: const Color.fromARGB(249, 250, 251, 255),
        child: ListView(
          scrollDirection: Axis.vertical,
          reverse: false,
          children: [
            DrawerHeader(
                child: Column(children: [
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, widget.screenHeight / 100),
                child: CircleAvatar(
                  backgroundColor: Colors.black,
                  backgroundImage: MemoryImage(
                      Provider.of<LoginData>(context, listen: false)
                          .profileImage) as ImageProvider?,
                  radius: widget.screenHeight / 14,
                ),
              ),
              Expanded(
                child: Text(
                    "${Provider.of<LoginData>(context).employeeName}\n${Provider.of<LoginData>(context).employeePosition}"),
              )
            ])),
            ListTile(
              title: Row(
                children: [
                  Container(
                    margin:
                        EdgeInsets.fromLTRB(0, 0, widget.screenWidth / 50, 0),
                    child: Icon(
                      Icons.home_filled,
                      color: Color.fromARGB(246, 243, 179, 2),
                      size: widget.screenWidth / 10,
                    ),
                  ),
                  Text('Anasayfa'),
                ],
              ),
              onTap: () async {
                await Navigator.pushNamed(context, '/home');
              },
            ),
            ListTile(
              title: Row(
                children: [
                  Container(
                    margin:
                        EdgeInsets.fromLTRB(0, 0, widget.screenWidth / 50, 0),
                    child: Icon(
                      Icons.person_2_sharp,
                      color: Color.fromARGB(246, 243, 179, 2),
                      size: widget.screenWidth / 10,
                    ),
                  ),
                  Text('Profilim'),
                ],
              ),
              onTap: () async {
                await Navigator.pushNamed(context, '/profile');
              },
            ),
            ListTile(
              title: Row(
                children: [
                  Container(
                    margin:
                        EdgeInsets.fromLTRB(0, 0, widget.screenWidth / 50, 0),
                    child: Icon(
                      Icons.checklist_outlined,
                      color: Color.fromARGB(246, 243, 179, 2),
                      size: widget.screenWidth / 10,
                    ),
                  ),
                  Text('Firma Öner'),
                ],
              ),
              onTap: () async {
                await Navigator.pushNamed(context, '/recommend');
              },
            ),
            ListTile(
              title: Row(
                children: [
                  Container(
                    margin:
                        EdgeInsets.fromLTRB(0, 0, widget.screenWidth / 50, 0),
                    child: Icon(
                      Icons.business,
                      color: Color.fromARGB(246, 243, 179, 2),
                      size: widget.screenWidth / 10,
                    ),
                  ),
                  Text('Yakın Firma Bul'),
                ],
              ),
              onTap: () async {
                await Navigator.pushNamed(context, '/search');
              },
            ),
            ListTile(
              title: Row(
                children: [
                  Container(
                    margin:
                        EdgeInsets.fromLTRB(0, 0, widget.screenWidth / 50, 0),
                    child: Icon(
                      Icons.lens,
                      color: Color.fromARGB(246, 243, 179, 2),
                      size: widget.screenWidth / 10,
                    ),
                  ),
                  Text('Firma Ara'),
                ],
              ),
              onTap: () async {
                await Navigator.pushNamed(context, '/list');
              },
            ),
            ListTile(
              title: Row(
                children: [
                  Container(
                    margin:
                        EdgeInsets.fromLTRB(0, 0, widget.screenWidth / 50, 0),
                    child: Icon(
                      Icons.calendar_today,
                      color: Color.fromARGB(246, 243, 179, 2),
                      size: widget.screenWidth / 10,
                    ),
                  ),
                  Text('Takvim'),
                ],
              ),
              onTap: () async {
                await Navigator.pushNamed(context, '/calendar');
              },
            ),
            ListTile(
              title: Row(
                children: [
                  Container(
                    margin:
                        EdgeInsets.fromLTRB(0, 0, widget.screenWidth / 50, 0),
                    child: Icon(
                      Icons.notifications_active,
                      color: Color.fromARGB(246, 243, 179, 2),
                      size: widget.screenWidth / 10,
                    ),
                  ),
                  Text('Hatırlatıcılar'),
                ],
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Row(
                children: [
                  Container(
                    margin:
                        EdgeInsets.fromLTRB(0, 0, widget.screenWidth / 50, 0),
                    child: Icon(
                      Icons.info,
                      color: Color.fromARGB(246, 243, 179, 2),
                      size: widget.screenWidth / 10,
                    ),
                  ),
                  Text('Hakkında'),
                ],
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Row(
                children: [
                  Container(
                    margin:
                        EdgeInsets.fromLTRB(0, 0, widget.screenWidth / 50, 0),
                    child: Icon(
                      Icons.settings,
                      color: Color.fromARGB(246, 243, 179, 2),
                      size: widget.screenWidth / 10,
                    ),
                  ),
                  Text('Ayarlar'),
                ],
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Row(
                children: [
                  Container(
                    margin:
                        EdgeInsets.fromLTRB(0, 0, widget.screenWidth / 50, 0),
                    child: Icon(
                      Icons.logout_outlined,
                      color: Color.fromARGB(246, 243, 179, 2),
                      size: widget.screenWidth / 10,
                    ),
                  ),
                  Text('Çıkış Yap'),
                ],
              ),
              onTap: () async {
                await signout();
              },
            ),
          ],
        ));
  }
}
