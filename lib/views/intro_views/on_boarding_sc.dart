// ignore_for_file: library_private_types_in_public_api, use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vast/core/routing.dart';
import 'package:vast/views/authntication/sign_in.dart';


class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _currentPage = 0;
  final PageController _pageController = PageController();

  final List<Map<String, dynamic>> _onboardingData = [
    {

      "title": "Welcome!",
      "subtitle": "You can buy your glasses from home.",
    },
    {

      "title": "Discover!",
      "subtitle": "We have a virtuial reality.",
    },
    {

      "title": "Get Started",
      "subtitle": "We are here for you.",
    },
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff3f3f3),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/onbording.jpg'),
            fit: BoxFit.cover
          )
        ),
        child: Stack(
          children: [
            PageView.builder(
              controller: _pageController,
              itemCount: _onboardingData.length,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemBuilder: (context, index) {
                return _buildPage(_onboardingData[index]);
              },
            ),
            Positioned(
              bottom: 20.0,
              left: 20.0,
              right: 20.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildNextButton(),
                  _buildPageIndicator(),
                  _buildDoneButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPage(Map<String, dynamic> data) {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            data["title"],
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              fontFamily: GoogleFonts.chewy().fontFamily
            ),
          ),
          SizedBox(height: 100),
          Text(
            data["subtitle"],
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16.0,
                fontFamily: GoogleFonts.chewy().fontFamily
            ),

          ),
        ],
      ),
    );
  }

  Widget _buildNextButton() {
    return ElevatedButton(
      onPressed: () {
        if (_currentPage < _onboardingData.length - 1) {
          _pageController.nextPage(
            duration: Duration(milliseconds: 500),
            curve: Curves.ease,
          );
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
      ),
      child: Text('Next',
      style: TextStyle(color: Colors.white ,
      fontWeight: FontWeight.bold,
          fontFamily: GoogleFonts.chewy().fontFamily
      ),
      ),
    );
  }

  Widget _buildDoneButton() {
    return ElevatedButton(
      onPressed: () {
        navgateWithReplac(context, signIn());
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black
      ),
      child: Text('Done',
      style: TextStyle(fontWeight: FontWeight.bold ,
      color: Colors.white,
          fontFamily: GoogleFonts.chewy().fontFamily
      ),
      ),
    );
  }

  Widget _buildPageIndicator() {
    return Row(
      children: [
        SizedBox(width: 20.0), // Spacer for alignment
        for (int i = 0; i < 3; i++)
          Container(
            width: 10.0,
            height: 10.0,
            margin: EdgeInsets.symmetric(horizontal: 5.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _currentPage ~/ (_onboardingData.length / 3) == i
                  ? Colors.black
                  : Colors.grey,
            ),
          ),
        SizedBox(width: 20.0), // Spacer for alignment
      ],
    );
  }
}
