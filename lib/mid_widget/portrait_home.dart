import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PortraitHome extends StatefulWidget {
  const PortraitHome({super.key});
  @override
  State<PortraitHome> createState() => PortraitHomeState();
}

class PortraitHomeState extends State<PortraitHome> {
  String userFirstName = "Toba";
  List data_list = ["Schedule", "Reports", "Contracts", "Statistics"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/home_background.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          SizedBox(
            height: 10,
          ),
          Container(
            height: 80,
            alignment: Alignment.centerLeft,
            child:
                Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
              Image.asset(
                'assets/logo.png',
                width: 100,
                height: 100,
              ),
              Text("KITA LOGISTICS",
                  style: GoogleFonts.ubuntu(
                      textStyle: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  )))
            ]),
          ),
          Container(
              height: 90,
              padding: EdgeInsets.all(10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Welcome, " + userFirstName + "!",
                      style: GoogleFonts.ubuntu(
                        textStyle: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontWeight: FontWeight.w600,
                            fontSize: 28),
                      )),
                  CircleAvatar(
                    radius: 35,
                    child: Image.asset('assets/gigachad.png'),
                    backgroundColor: Color.fromARGB(255, 22, 13, 57),
                  ),
                ],
              )),
          SizedBox(
            height: 15,
          ),
          Container(
            height: 400,
            width: 350,
            child: GridView.count(
                crossAxisCount: 2,
                children: List.generate(
                  4,
                  (index) => Center(
                      child: SizedBox(
                          child: Container(
                    margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(8),
                    width: 300,
                    height: 400,
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 1, 44, 71),
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(0.2, 0.2),
                              blurRadius: 3,
                              color: Color.fromRGBO(231, 198, 10, 1))
                        ]),
                    child: Text(
                      data_list[index],
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                            color: Color.fromARGB(202, 217, 197, 44),
                            fontWeight: FontWeight.bold,
                            fontSize: 30),
                      ),
                    ),
                  ))),
                )),
          ),
        ]),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromARGB(221, 57, 0, 62),
        unselectedItemColor: Color.fromARGB(255, 23, 234, 83),
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
              color: Colors.blue,
            ),
            label: "Search",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings,
              color: Colors.blue,
            ),
            label: "Options",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.menu,
              color: Colors.blue,
            ),
            label: "Profile",
          )
        ],
      ),
    );
  }
}
