// ignore_for_file: camel_case_types, unnecessary_import, use_super_parameters, prefer_const_constructors, sort_child_properties_last

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vast/core/routing.dart';
import 'package:vast/views/authntication/sign_in.dart';
import 'package:vast/views/authntication/wedigt/custome_textfield.dart';
import 'package:vast/views/catogries/catogries_sc.dart';

class register extends StatefulWidget {
  const register({Key? key}) : super(key: key);

  @override
  State<register> createState() => _registerState();
}

class _registerState extends State<register> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isNotShow = true;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage('assets/glassesss/signnn.jpg'),
                      radius: 100,
                    ),
                    Text(
                      'Login Now!',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          fontFamily: GoogleFonts.chewy().fontFamily),
                    ),
                    SizedBox(height: 50),
                    CustomTextF(
                      lab: 'Email',
                      pre: Icons.email,
                      mycontroller: emailController,
                    ),
                    SizedBox(height: 20),
                    CustomTextF(
                      mycontroller: passwordController,
                      lab: 'Password',
                      pre: Icons.lock,
                      obscure: true,
                      suffixIcon: isNotShow
                          ? Icons.visibility_off
                          : Icons.remove_red_eye,
                      suffixFun: () {
                        setState(() {
                          isNotShow = !isNotShow;
                        });
                      },
                    ),
                    SizedBox(height: 50),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          try {
                            UserCredential userCredential =
                            await FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                              email: emailController.text,
                              password: passwordController.text,
                            );
                            navgateWithReplac(context, cato());
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'user-not-found') {
                              showErrorDialog('No user found for that email.');
                            } else if (e.code == 'wrong-password') {
                              showErrorDialog(
                                  'Wrong password provided for that user.');
                            } else {
                              showErrorDialog(e.message!);
                            }
                          } catch (e) {
                            showErrorDialog(e.toString());
                          }
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              fontFamily: GoogleFonts.chewy().fontFamily),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'If you do not have an account',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: GoogleFonts.chewy().fontFamily),
                        ),
                        Expanded(
                          child: TextButton(
                              onPressed: () {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) => signIn()));
                              },
                              child: Text(
                                'Create One!',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontFamily: GoogleFonts.chewy().fontFamily),
                              )),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
