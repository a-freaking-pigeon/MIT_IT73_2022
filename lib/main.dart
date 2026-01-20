import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'services/auth_service.dart';

void main() {
  AuthService.currentRole = UserRole.guest;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StudentMarket',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
      ),
      home: const SplashScreen(),
    );
  }
}
