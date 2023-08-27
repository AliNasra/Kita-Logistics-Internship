import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:practice_application/map_data.dart';
import 'drawer.dart';
import 'dart:math' as math;
import 'package:provider/provider.dart';
import 'database_data.dart';

class search extends StatefulWidget {
  double screenHeight = 0;
  double screenWidth = 0;
  search(this.screenHeight, this.screenWidth);

  @override
  State<search> createState() => searchState();
}

class searchState extends State<search> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  void initState() {
    super.initState();
    Provider.of<DatabaseData>(context, listen: false).setCenter(context);
    Provider.of<DatabaseData>(context, listen: false).setEmployeeName(context);
    Provider.of<DatabaseData>(context, listen: false).clearWidgetList();
    (() async {
      await Provider.of<DatabaseData>(context, listen: false)
          .getCompanies(context, widget.screenHeight, widget.screenWidth);
    })();
  }

  Widget build(BuildContext context) {
    double tempHeight = MediaQuery.of(context).size.height;
    double tempWidth = MediaQuery.of(context).size.width;
    final databaseModel = Provider.of<DatabaseData>(context, listen: false);
    double screenHeight =
        (MediaQuery.of(context).orientation == Orientation.portrait
            ? tempHeight
            : tempWidth);
    double screenWidth = tempWidth;
    Provider.of<MapData>(context, listen: false).updateCurrentLocation();
    return Scaffold(
        key: _scaffoldKey,
        drawer: MainDrawer(screenHeight, screenWidth, context),
        body: Container(
          height: screenHeight,
          width: screenWidth,
          padding: EdgeInsets.fromLTRB(
              screenWidth / 20, screenHeight / 20, screenWidth / 20, 0),
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.topRight,
            colors: [
              Color.fromARGB(255, 6, 4, 1),
              Color.fromARGB(255, 254, 191, 52),
            ],
          )),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, screenHeight / 50),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          child: Container(
                            child: Icon(
                              Icons.menu_outlined,
                              size: screenHeight / 15,
                              color: Colors.white,
                            ),
                          ),
                          onTap: () => _scaffoldKey.currentState!.openDrawer(),
                        ),
                        GestureDetector(
                          child: Container(
                            child: Icon(
                              Icons.filter_alt_outlined,
                              size: screenHeight / 15,
                              color: Colors.white,
                            ),
                          ),
                          onTap: () {
                            databaseModel.addSector(
                                screenHeight, screenWidth, context);
                          },
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(screenWidth / 40, 0,
                        screenWidth / 20, screenHeight / 40),
                    child: Column(
                      children: [
                        Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "ARAMA YAP",
                              style: GoogleFonts.quicksand(
                                  textStyle: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w900,
                                      fontSize: screenHeight / 25)),
                              softWrap: true,
                            )),
                        Container(
                          margin:
                              EdgeInsets.fromLTRB(0, screenHeight / 50, 0, 0),
                          width: screenWidth / 1.2,
                          height: screenHeight / 20,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.topRight,
                                colors: [
                                  Color.fromARGB(255, 254, 191, 52),
                                  Color.fromARGB(255, 255, 157, 79)
                                ],
                              ),
                              borderRadius:
                                  BorderRadius.circular(screenHeight / 80)),
                          child: Consumer<DatabaseData>(
                              builder: (context, DatabaseData, child) {
                            return TextField(
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.fromLTRB(
                                        screenWidth / 60,
                                        screenHeight / 300,
                                        screenWidth / 60,
                                        0),
                                    border: InputBorder.none,
                                    suffixIcon: GestureDetector(
                                      child: Container(
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Color.fromARGB(
                                                255, 207, 207, 207)),
                                        child: Icon(
                                          Icons.close_outlined,
                                          color: Colors.white,
                                        ),
                                      ),
                                      onTap: () async {
                                        DatabaseData.setQuery(
                                            "", screenHeight, screenWidth);
                                        await DatabaseData.setFilteringText(
                                            context,
                                            "",
                                            screenHeight,
                                            screenWidth);
                                      },
                                    )),
                                controller: DatabaseData.getController(),
                                onChanged: (input) async {
                                  await DatabaseData.setFilteringText(context,
                                      input, screenHeight, screenWidth);
                                });
                          }),
                        ),
                        Consumer<DatabaseData>(
                            builder: (context, DatabaseData, child) {
                          return SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Container(
                                margin: EdgeInsets.fromLTRB(
                                    0, screenHeight / 40, 0, 0),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: DatabaseData.renderSectors(context,
                                        screenHeight, screenWidth)),
                              ));
                        }),

                        //;})),
                        Consumer<DatabaseData>(
                            builder: (context, DatabaseData, child) {
                          return Container(
                              width: screenWidth / 1.1,
                              height: screenHeight / 1.9,
                              margin: EdgeInsets.fromLTRB(
                                  0, screenHeight / 40, 0, 0),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: DatabaseData.companyListWidget),
                              ));
                        }),
                        Transform.rotate(
                          angle: -math.pi / 2,
                          child: GestureDetector(
                            child: Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white,
                              size: screenHeight / 10,
                            ),
                            onTap: () async {
                              await Navigator.pushNamed(context, '/map');
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
