import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddressCard extends StatefulWidget {
  AddressCard({super.key});

  @override
  State<AddressCard> createState() => AddressCardState();
}

class AddressCardState extends State<AddressCard> {
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    final params = ((ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map);
    Map<dynamic, dynamic> companyData = params["companyData"];
    //print("company data is ${companyData}");
    double tempHeight = MediaQuery.of(context).size.height;
    double tempWidth = MediaQuery.of(context).size.width;
    double screenHeight =
        (MediaQuery.of(context).orientation == Orientation.portrait
            ? tempHeight
            : tempWidth);
    double screenWidth = tempWidth;
    return Scaffold(
        body: Container(
      child: Column(children: [
        Container(
          color: Colors.amber,
          height: screenHeight / 3.5,
          width: screenWidth,
          padding:
              EdgeInsets.fromLTRB(screenWidth / 20, screenHeight / 20, 0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, screenHeight / 15),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                    size: screenHeight / 25,
                  ),
                ),
              ),
              Container(
                child: Text(companyData['name'],
                    style: GoogleFonts.quicksand(
                        textStyle: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontSize: screenHeight / 30))),
              ),
              Container(
                child: Text(companyData['fullName'],
                    style: GoogleFonts.quicksand(
                        textStyle: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontSize: screenHeight / 40))),
              ),
              Container(
                child: Text(companyData['sector'],
                    style: GoogleFonts.quicksand(
                        textStyle: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontSize: screenHeight / 40))),
              )
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(screenWidth / 20, 0, 0, 0),
          alignment: Alignment.centerLeft,
          height: screenHeight / 1.5,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              child: Text("Özel Bilgi",
                  style: GoogleFonts.quicksand(
                      textStyle: TextStyle(
                          color: Colors.amber,
                          fontWeight: FontWeight.w900,
                          fontSize: screenHeight / 30))),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, screenHeight / 50),
              child: Text(companyData['fullName'],
                  style: GoogleFonts.quicksand(
                      textStyle: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w900,
                          fontSize: screenHeight / 45))),
            ),
            Container(
              child: Text("Adres",
                  style: GoogleFonts.quicksand(
                      textStyle: TextStyle(
                          color: Colors.amber,
                          fontWeight: FontWeight.w900,
                          fontSize: screenHeight / 30))),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, screenHeight / 50),
              child: Text(companyData['address'],
                  style: GoogleFonts.quicksand(
                      textStyle: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w900,
                          fontSize: screenHeight / 45))),
            ),
            Container(
              child: Text("İletişim No",
                  style: GoogleFonts.quicksand(
                      textStyle: TextStyle(
                          color: Colors.amber,
                          fontWeight: FontWeight.w900,
                          fontSize: screenHeight / 30))),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, screenHeight / 50),
              child: Text("123123",
                  style: GoogleFonts.quicksand(
                      textStyle: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w900,
                          fontSize: screenHeight / 45))),
            ),
            Container(
              child: Text("Yetkili Adı",
                  style: GoogleFonts.quicksand(
                      textStyle: TextStyle(
                          color: Colors.amber,
                          fontWeight: FontWeight.w900,
                          fontSize: screenHeight / 30))),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, screenHeight / 50),
              child: Text(companyData['salesperson'],
                  style: GoogleFonts.quicksand(
                      textStyle: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w900,
                          fontSize: screenHeight / 45))),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, screenHeight / 50),
              child: Text("Geçmiş Aktivite",
                  style: GoogleFonts.quicksand(
                      textStyle: TextStyle(
                          color: Colors.amber,
                          fontWeight: FontWeight.w900,
                          fontSize: screenHeight / 30))),
            ),
            Container(
              height: screenHeight / 10,
              width: screenWidth / 1.1,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(screenHeight / 70),
                  color: Colors.amber),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(
                  screenWidth / 10, screenHeight / 35, 0, 0),
              width: screenWidth / 1.4,
              height: screenHeight / 15,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.amber,
                  border:
                      Border.all(color: Colors.amber, width: screenWidth / 100),
                  borderRadius:
                      BorderRadius.all(Radius.circular(screenHeight / 50))),
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.amber,
                ),
                onPressed: () async {},
                child: Container(
                    child: Text(
                  "Yol Tarifi oluştur",
                  style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: screenHeight / 40)),
                  softWrap: true,
                )),
              ),
            ),
          ]),
        )
      ]),
    ));
  }
}
