// ignore_for_file: unused_local_variable, duplicate_import, unused_import, camel_case_types

import 'package:camera/camera.dart';
import 'package:ffmpeg_kit_flutter/ffmpeg_kit_config.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:vast/views/authntication/sign_in.dart';
import 'package:vast/views/intro_views/splash_sc.dart';
import 'views/intro_views/on_boarding_sc.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  options: const FirebaseOptions(
    apiKey: 'AIzaSyBnmc4GgW2Do3Ogoj6nQlJALmYxlTRFRLA',
    appId: '1:999787853949:android:ff7385d36b0d5688281914',
    messagingSenderId: '999787853949',
    projectId: 'vast-1f5b4',
    storageBucket: 'myapp-b9yt18.appspot.com',
  )
);
// Obtain a list of the available cameras
  final cameras = await availableCameras();

  // Get the front camera from the list
  final frontCamera = cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.front,
    orElse: () =>

    cameras.first, // If no front camera is available, use the first camera
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: splash(),

    );
  }
}
