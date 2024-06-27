import 'package:flutter/material.dart';

navgateWithReplac(context , Widget newScreen){
  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>newScreen));
}

navgateto(context , Widget newScreen){
  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>newScreen));
}