import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LandscapeHome extends StatefulWidget {
  const LandscapeHome({super.key});

  @override
  State<LandscapeHome> createState() => LandscapeHomeState();
}

class LandscapeHomeState extends State<LandscapeHome> {
  String userFirstName = "Toba";
  List data_list = ["Schedule", "Reports", "Contracts", "Statistics"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/home_background_landscape.jpg"),
                fit: BoxFit.fill)),
        child: Container(
          child: Column(children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Row(children: [
                    Image.asset(
                      "assets/logo.png",
                      width: 80,
                      height: 80,
                    ),
                    Text(
                      "KITA LOGISTICS",
                      style: GoogleFonts.ubuntu(
                          textStyle: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      )),
                      softWrap: true,
                    )
                  ]),
                ),
                Flexible(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Welcome, " + userFirstName + "!",
                        style: GoogleFonts.ubuntu(
                          textStyle: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontWeight: FontWeight.w600,
                              fontSize: 20),
                        ),
                        softWrap: true,
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage("assets/gigachad.png"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              height: 200,
              child: GridView.count(
                  crossAxisCount: 4,
                  children: List.generate(
                    4,
                    (index) => Center(
                        child: SizedBox(
                            child: Container(
                      margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(8),
                      width: 250,
                      height: 300,
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
                              fontSize: 28),
                        ),
                      ),
                    ))),
                  )),
            )
          ]),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Color.fromARGB(255, 43, 226, 7),
        backgroundColor: Color.fromARGB(221, 57, 0, 62),
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
