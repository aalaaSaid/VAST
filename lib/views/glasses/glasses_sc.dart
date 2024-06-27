// ignore_for_file: camel_case_types, library_private_types_in_public_api

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

 import 'package:vast/core/routing.dart';
import 'package:vast/views/camera_show/camera_sc.dart';
import 'package:vast/views/glasses/custome_glass.dart';
import 'package:vast/views/glasses/glass_model.dart';

import '../../core/routing.dart';
// Import CameraApp class

class Home_page extends StatefulWidget {
  const Home_page({super.key});

  @override
  _Home_pageState createState() => _Home_pageState();
}

class _Home_pageState extends State<Home_page> {
  late CameraDescription? frontCamera;

  @override
  void initState() {
    super.initState();
    _getFrontCamera();
  }

  // Function to get the front camera
  void _getFrontCamera() async {
    WidgetsFlutterBinding.ensureInitialized();
    final cameras = await availableCameras();
    setState(() {
      frontCamera = cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.front,
        orElse: () => cameras
            .first, // If no front camera is available, use the first camera
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff3f3f3),
      appBar: AppBar(
        backgroundColor: const Color(0xfff3f3f3),
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Glasses',
          style: TextStyle(
              fontSize: 36,
              color: Colors.black,
              fontFamily: GoogleFonts.chewy().fontFamily
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.shopping_cart_outlined,
              color: Colors.black,
              size: 36,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.person,
              color: Colors.black,
              size: 36,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: GridView.builder(
          itemCount: glassesList.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, crossAxisSpacing: 5),
          itemBuilder: (context, index) {
            return glass(
              image: glassesList[index].image,
              price: glassesList[index].price,
              onTap: () {
                navgateto(
                   context,
                     CameraApp(
                       glassesNumber: glassesList[index].id,
                     ));
              },
            );
          },
        ),
      ),
    );
  }
}
