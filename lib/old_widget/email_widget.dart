import 'package:flutter/material.dart';
import 'specifications.dart';

class emailWidget extends StatelessWidget{


    const emailWidget({
      Key ? key
    }) : super(key: key);
    
    @override
    Widget build(BuildContext context) {
          return SizedBox(
            width: 300,
            child: TextField(
            decoration: InputDecoration(
                border:  OutlineInputBorder(
                  borderRadius:BorderRadius.circular(20),
                  borderSide: BorderSide(color:colorGrey,width: 10,),  
                ),
                hintText: 'Enter your email',
                hintStyle: TextStyle(color: colorWhite,fontSize: 20),
                contentPadding: EdgeInsets.symmetric(vertical:5,horizontal: 15),
                suffixIcon: IconButton(
                icon: Icon(Icons.email_rounded),
                onPressed: () {},
                ),
              ),
              style: TextStyle(fontSize: 15,color: colorWhite,fontWeight: FontWeight.bold),
            ) 
          );
    }




}