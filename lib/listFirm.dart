import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:practice_application/database_data.dart';
import 'package:provider/provider.dart';

import 'drawer.dart';

class ListFirm extends StatefulWidget {
  const ListFirm({super.key});

  @override
  State<ListFirm> createState() => ListFirmState();
}

class ListFirmState extends State<ListFirm> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    Provider.of<DatabaseData>(context, listen: false).clearCompanies();
    Provider.of<DatabaseData>(context, listen: false).setEmployeeName(context);
  }

  Widget build(BuildContext context) {
    double tempHeight = MediaQuery.of(context).size.height;
    double tempWidth = MediaQuery.of(context).size.width;
    double screenHeight =
        (MediaQuery.of(context).orientation == Orientation.portrait
            ? tempHeight
            : tempWidth);
    double screenWidth = tempWidth;
    return Scaffold(
        key: _scaffoldKey,
        drawer: MainDrawer(screenHeight, screenWidth, context),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            child: Column(
              children: [
                Container(
                  color: Color.fromARGB(255, 251, 211, 128),
                  child: Column(
                    children: [
                      Container(
                          margin: EdgeInsets.fromLTRB(
                              screenWidth / 60,
                              screenHeight / 15,
                              screenWidth / 60,
                              screenHeight / 15),
                          padding: EdgeInsets.fromLTRB(
                              screenWidth / 40, 0, screenWidth / 40, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () =>
                                    _scaffoldKey.currentState!.openDrawer(),
                                child: Container(
                                  child: Icon(
                                    Icons.menu_outlined,
                                    color: Color.fromARGB(246, 243, 179, 2),
                                    size: screenHeight / 12,
                                  ),
                                ),
                              ),
                              Container(
                                child: Icon(
                                  Icons.notification_add_outlined,
                                  color: Color.fromARGB(246, 243, 179, 2),
                                  size: screenHeight / 12,
                                ),
                              ),
                            ],
                          )),
                      Container(
                        padding: EdgeInsets.only(left: screenWidth / 20),
                        margin: EdgeInsets.only(bottom: screenHeight / 50),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Firma Listesi",
                              style: GoogleFonts.quicksand(
                                  textStyle: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w900,
                                      fontSize: screenHeight / 25)),
                              softWrap: true,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(
                            screenWidth / 40,
                            screenHeight / 59,
                            screenWidth / 40,
                            screenHeight / 50),
                        child: Row(
                          children: [
                            Container(
                              height: screenHeight / 18,
                              width: screenWidth / 1.5,
                              padding: EdgeInsets.fromLTRB(
                                  0, screenHeight / 200, 0, screenHeight / 200),
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(screenHeight / 80),
                                  border: Border.all(
                                      color: Colors.black,
                                      width: screenHeight / 200)),
                              child: TextField(
                                controller: Provider.of<DatabaseData>(context,
                                        listen: false)
                                    .listFirmTextController,
                                textAlign: TextAlign.left,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  prefixIcon: GestureDetector(
                                    onTap: () async {
                                      FocusManager.instance.primaryFocus
                                          ?.unfocus();

                                      await Provider.of<DatabaseData>(context,
                                              listen: false)
                                          .retrieveCompanies(context,
                                              screenHeight, screenWidth);
                                      setState(() {});
                                    },
                                    child: Icon(
                                      Icons.search,
                                      color: Colors.black,
                                    ),
                                  ),
                                  suffixIcon: GestureDetector(
                                      child: Icon(
                                        Icons.close_outlined,
                                        color: Colors.black,
                                      ),
                                      onTap: () {
                                        Provider.of<DatabaseData>(context,
                                                listen: false)
                                            .clearListCompanyTextController();
                                      }),
                                ),
                                style: TextStyle(
                                    fontSize: screenHeight / 50,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: screenWidth / 6),
                              child: Icon(
                                Icons.tune,
                                color: Colors.black,
                                size: screenHeight / 20,
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                          height: screenHeight / 2,
                          width: screenWidth / 1.1,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Column(
                              children: Provider.of<DatabaseData>(context,
                                      listen: false)
                                  .companyListWidget,
                            ),
                          )),
                      Container(
                          margin: EdgeInsets.only(top: screenHeight / 30),
                          padding: EdgeInsets.fromLTRB(
                              screenWidth / 50, 0, screenWidth / 50, 0),
                          width: screenWidth / 1.5,
                          height: screenHeight / 25,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                                Radius.circular(screenHeight / 20)),
                            color: Color.fromARGB(255, 251, 211, 128),
                            border: Border.all(
                                color: Color.fromARGB(255, 251, 211, 128),
                                width: screenWidth / 500),
                          ),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(Icons.home_filled, color: Colors.white),
                                Icon(Icons.place_rounded, color: Colors.white),
                                Icon(Icons.person_2_rounded,
                                    color: Colors.white),
                                Icon(Icons.checklist_rounded,
                                    color: Colors.white),
                              ]))
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
