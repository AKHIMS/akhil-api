// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, sized_box_for_whitespace

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screen/top_hits.dart';

class VideoFirstPage extends StatefulWidget {
  const VideoFirstPage({Key? key, this.countryCode}) : super(key: key);

  final String? countryCode;

  @override
  _VideoFirstPageState createState() => _VideoFirstPageState();
}

class _VideoFirstPageState extends State<VideoFirstPage> {
  bool _isButtonVisible = false;

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      setState(() {
        _isButtonVisible = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          GestureDetector(
            onTap: () {
              _navigateToTopHits(context);
            },
            child: Container(
              color: Colors.transparent,
              child: Image.asset(
                'assets/uae.png', // Replace 'your_image.jpg' with your image path
                fit: BoxFit.cover,
                height: MediaQuery.of(context)
                    .size
                    .height, // Adjust height as needed
                width:
                    MediaQuery.of(context).size.width, // Adjust width as needed
              ),
            ),
          ),
          Positioned(
            top: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Image.asset(
                'assets/emirates.png', // Replace 'your_second_image.png' with your second image path
                fit: BoxFit.cover,
              ),
            ),
          ),
          AnimatedOpacity(
            duration: Duration(milliseconds: 500),
            opacity: _isButtonVisible ? 1.0 : 0.0,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: 40.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TopHits()),
                    );
                  },
                  child: Text(
                    'Continue',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToTopHits(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TopHits()),
    );
  }
}
