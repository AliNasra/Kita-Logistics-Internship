import 'package:flutter/material.dart';

class signInWidget extends StatelessWidget{


    const signInWidget({
      Key ? key
    }) : super(key: key);
    
    @override
    Widget build(BuildContext context) {
          return SizedBox(
                height: 50,
                width: 150,
                child:TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.yellowAccent[700],
            ),
            onPressed: () { },
          child: const Text('Sign in',style: TextStyle(color: Colors.black,fontSize: 12,fontWeight: FontWeight.w700),)
          )
          );
    }




}