import 'package:flutter/material.dart';
import 'specifications.dart';

class InfoWidget extends StatelessWidget{

  const InfoWidget({
      Key ? key
  }) : super (key:key);
  
  @override
  Widget build(BuildContext context ){
      return Container(
        padding: const EdgeInsets.all(10),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("LOGIN",style: TextStyle(color: colorWhite ,fontWeight: FontWeight.bold ,fontSize: 30 ) ,),
            SizedBox(height: 10),
            Text("Kindly Insert Your Credentials Correctly!",style: TextStyle(color: colorWhite ,fontWeight: FontWeight.w500 ,fontSize: 20)),
          ],
        )
      );
  }

}