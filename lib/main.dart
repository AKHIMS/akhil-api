// ignore_for_file: prefer_const_constructors, unused_import

import 'package:flutter/material.dart';
import 'package:flutter_application_1/fistpage.dart';
import 'package:flutter_application_1/screen/top_hits.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Define the country code here or fetch it from somewhere
    String countryCode = '+1'; // Example: Set the default country code

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Assuming you want to use Material Design 3 features
        useMaterial3: true,
        // Choosing a primary color for your theme
        primarySwatch: Colors.green,
      ),
      home: VideoFirstPage(countryCode: countryCode),
    );
  }
}
