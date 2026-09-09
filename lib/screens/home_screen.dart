import 'package:flutter/material.dart';

import 'device_scanner_screen.dart';
import 'network_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'NetShield',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            const SizedBox(height: 30),

            const Icon(
              Icons.security,
              size: 90,
              color: Colors.blueAccent,
            ),

            const SizedBox(height: 20),

            const Text(
              'Network Security Scanner',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              'Analyze your authorized network',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white60,
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 40),

            SizedBox(
              width: double.infinity,
              height: 55,

              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                      const NetworkScreen(),
                    ),
                  );
                },

                icon: const Icon(
                  Icons.wifi_find,
                ),

                label: const Text(
                  'Network Information',
                  style:
                  TextStyle(fontSize: 17),
                ),
              ),
            ),

            const SizedBox(height: 15),

            SizedBox(
              width: double.infinity,
              height: 55,

              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                      const DeviceScannerScreen(),
                    ),
                  );
                },

                icon: const Icon(
                  Icons.devices,
                ),

                label: const Text(
                  'Scan Network Devices',
                  style:
                  TextStyle(fontSize: 17),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}