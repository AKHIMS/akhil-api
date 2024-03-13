// ignore_for_file: prefer_const_constructors, unused_import, avoid_print

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/CreateAccountPage.dart';
import 'package:flutter_application_1/screen/nextpge.dart';

class TopHits extends StatefulWidget {
  const TopHits({Key? key,  this.countryCode}) : super(key: key);

  final String? countryCode;

  @override
  State<TopHits> createState() => _TopHitsState();
}

class _TopHitsState extends State<TopHits> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  bool _showSkipButton = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _offsetAnimation = Tween<Offset>(
      begin: Offset(0.0, -1.0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.fastOutSlowIn,
      ),
    );

    _timer = Timer(Duration(seconds: 3), () {
      setState(() {
        _showSkipButton = true;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _timer.cancel();
    super.dispose();
  }

  void _login() {
    String email = _emailController.text;
    String password = _passwordController.text;
    // Perform authentication logic here, for now just print the email and password
    print('Email: $email, Password: $password');
    // After successful login, navigate to the second page
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EmployeeListScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Image.asset(
            'assets/image1.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Positioned(
            top: 112,
            left: 11,
            child: Image.asset(
              'assets/logoflyemirates.png',
              width: 300,
              height: 300,
            ),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        _controller.forward();
                      },
                      child: Text('Login'),
                    ),
                    SizedBox(width: 10),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: ElevatedButton(
              onPressed: _login,
              child: Text('create account'),
            ),
          ),
          AnimatedBuilder(
            animation: _controller,
            builder: (BuildContext context, Widget? child) {
              return SlideTransition(
                position: _offsetAnimation,
                child: IgnorePointer(
                  ignoring: _controller.status == AnimationStatus.reverse ||
                      _controller.status == AnimationStatus.dismissed,
                  child: GestureDetector(
                    onTap: () {
                      if (_controller.status == AnimationStatus.completed) {
                        _controller.reverse();
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      color: Colors.black.withOpacity(0.7),
                      child: Center(
                        child: Card(
                          elevation: 5,
                          color: Colors.white.withOpacity(0.8),
                          child: Container(
                            padding: EdgeInsets.all(20),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextField(
                                  controller: _emailController,
                                  decoration: InputDecoration(
                                    labelText: 'Email',
                                  ),
                                ),
                                SizedBox(height: 10),
                                TextField(
                                  controller: _passwordController,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    labelText: 'Password',
                                  ),
                                ),
                                SizedBox(height: 10),
                                ElevatedButton(
                                  onPressed: _login,
                                  child: Text('Login'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder:(context) => CreateAccount()),
                                    );
                                  },
                                  child: Text('Create Account'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          if (_showSkipButton)
            Positioned(
              top: 50,
              right: 20,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'Skip',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
