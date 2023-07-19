import 'package:flutter/material.dart';
import 'specifications.dart';

class passwordWidget extends StatelessWidget{


    const passwordWidget({
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
                 hintText: 'Enter your password',
                 hintStyle: TextStyle(color: colorWhite,fontSize: 20),
                 contentPadding: EdgeInsets.symmetric(vertical:5,horizontal: 15),
                 suffixIcon: IconButton(
               icon: Icon(Icons.visibility_off),
               onPressed: () {},
              ),
              ),
              style: TextStyle(fontSize: 15,color: colorWhite,fontWeight: FontWeight.bold),
            ) 
          );
    }




}