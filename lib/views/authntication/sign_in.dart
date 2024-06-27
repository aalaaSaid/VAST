import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vast/core/routing.dart';
import 'package:vast/views/authntication/sign_up.dart';
import 'package:vast/views/authntication/wedigt/custome_textfield.dart';
import 'package:vast/views/catogries/catogries_sc.dart';

class signIn extends StatefulWidget {
  const signIn({Key? key}) : super(key: key);

  @override
  State<signIn> createState() => _signInState();
}

class _signInState extends State<signIn> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  bool isNotShow = true;

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
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
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundImage:
                        AssetImage('assets/glassesss/signnn.jpg'),
                        radius: 100,
                      ),
                      Text(
                        'Join with us now!',
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
                        lab: 'Password',
                        mycontroller: passwordController,
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
                      SizedBox(height: 20),
                      CustomTextF(
                        lab: 'Name',
                        pre: Icons.person,
                        mycontroller: nameController,
                      ),
                      SizedBox(height: 30),
                      SizedBox(
                        width: double.infinity,
                        child: MaterialButton(
                          height: 40,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          color: Colors.black,
                          onPressed: () async {
                            try {
                              final credential = await FirebaseAuth.instance
                                  .createUserWithEmailAndPassword(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                              navgateWithReplac(context, register());
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'weak-password') {
                                showErrorDialog('The password provided is too weak.');
                              } else if (e.code == 'email-already-in-use') {
                                showErrorDialog(
                                    'The account already exists for that email.');
                              }
                            } catch (e) {
                              showErrorDialog(e.toString());
                            }
                          },
                          child: Text(
                            "Register",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: GoogleFonts.chewy().fontFamily),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'If you have an account',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: GoogleFonts.chewy().fontFamily),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) => register()));
                              },
                              child: Text(
                                'Login Now!',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontFamily: GoogleFonts.chewy().fontFamily),
                              ))
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
