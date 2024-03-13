// ignore_for_file: prefer_const_constructors, avoid_print, use_build_context_synchronously, unused_element, use_super_parameters

import 'package:flutter/material.dart';

import 'screens/employee_addemployes.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your App Title',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: EmployeeAdd(onTap: () { },),
    );
  }
}
