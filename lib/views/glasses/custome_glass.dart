// ignore_for_file: unnecessary_import, unused_import, camel_case_types, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:vast/core/routing.dart';

class glass extends StatelessWidget {
  final String? image;
  final String? price;
  final Function() onTap;
  glass({required this.image, required this.price, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: InkWell(
            onTap: onTap ,
            child: Container(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey),
                image: DecorationImage(
                  image: AssetImage(image! ,),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              price!,
              style: TextStyle(fontWeight: FontWeight.bold,
                  fontFamily: GoogleFonts.chewy().fontFamily,
                  fontSize: 20),
            ),
            SizedBox(
              width: 30,
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.shopping_cart_outlined,
                size: 30,
              ),
            )
          ],
        ),
      ],
    );
  }
}
