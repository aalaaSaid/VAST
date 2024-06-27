import 'package:flutter/material.dart';

class CustomTextF extends StatelessWidget {
  const CustomTextF(
      {super.key, required this.lab,
      required this.pre,
      this.suffixIcon,
      this.suffixFun,
      this.obscure,
        required this.mycontroller});

  final String lab;
  final TextEditingController mycontroller;
  final IconData pre;

  final IconData? suffixIcon;

  final Function()? suffixFun;

  final bool? obscure;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: mycontroller,
      obscureText: obscure ?? false,
      decoration: InputDecoration(
          prefixIcon: Icon(
            pre,
            color: Colors.black,
          ),
          label: Text(lab),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.black),
          ),
          suffixIcon: suffixIcon != null
              ? IconButton(
                  onPressed: suffixFun,
                  icon: Icon(
                    suffixIcon,
                    color: Colors.black,
                  ))
              : const SizedBox(),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.black))),
    );
  }
}
