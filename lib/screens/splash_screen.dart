import 'dart:async';

import 'package:flutter/material.dart';

import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() =>
      _SplashScreenState();
}

class _SplashScreenState
    extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(_controller);

    _controller.forward();

    Timer(
      const Duration(seconds: 3),
          () {
        if (!mounted) return;

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
            const HomeScreen(),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,

        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF06111F),
              Color(0xFF0B2545),
              Color(0xFF123C69),
            ],

            begin:
            Alignment.topCenter,

            end:
            Alignment.bottomCenter,
          ),
        ),

        child: FadeTransition(
          opacity: _fadeAnimation,

          child: Column(
            mainAxisAlignment:
            MainAxisAlignment.center,

            children: [
              Container(
                width: 130,
                height: 130,

                decoration:
                BoxDecoration(
                  shape: BoxShape.circle,

                  color: Colors.white
                      .withOpacity(0.08),

                  boxShadow: [
                    BoxShadow(
                      color: Colors
                          .blueAccent
                          .withOpacity(
                          0.35),

                      blurRadius: 30,

                      spreadRadius: 5,
                    ),
                  ],
                ),

                child: const Icon(
                  Icons.security,
                  size: 75,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 30),

              const Text(
                'NetShield',

                style: TextStyle(
                  fontSize: 36,
                  fontWeight:
                  FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 1.5,
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                'Network Security Scanner',

                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                  letterSpacing: 0.5,
                ),
              ),

              const SizedBox(height: 50),

              const SizedBox(
                width: 35,
                height: 35,

                child:
                CircularProgressIndicator(
                  strokeWidth: 3,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 15),

              const Text(
                'Initializing Security Scanner...',

                style: TextStyle(
                  color: Colors.white54,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}