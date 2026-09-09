import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:network_tools/network_tools.dart';

import 'screens/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final appDirectory =
  await getApplicationDocumentsDirectory();

  await configureNetworkTools(
    appDirectory.path,
    enableDebugging: false,
  );

  runApp(const NetShieldApp());
}

class NetShieldApp extends StatelessWidget {
  const NetShieldApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'NetShield',

      theme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,

        colorScheme:
        ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
      ),

      home: const SplashScreen(),
    );
  }
}