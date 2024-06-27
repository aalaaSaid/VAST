// ignore_for_file: camel_case_types, use_key_in_widget_constructors, must_be_immutable, prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/routing.dart';
import '../glasses/glasses_sc.dart';

class custome_cato extends StatelessWidget {
  custome_cato({required this.image, required this.name});
  String? image ;
  String? name ;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(10),
        width: double.infinity,
        height: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 80,
              width: 80,
              child: CircleAvatar(
                backgroundImage: AssetImage(image!
                ),
              ),
            ) ,
            Text( name!,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  fontFamily: GoogleFonts.chewy().fontFamily
              ),
            ),
            IconButton(onPressed: (){
              navgateto(context, Home_page());
            }, icon: Icon(Icons.navigate_next_rounded,
              size: 30,
            ))
          ],
        ),

      ),
    );
  }
}
