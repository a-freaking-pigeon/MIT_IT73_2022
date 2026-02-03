import 'package:flutter/material.dart';
import 'login_screen.dart';


class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Theme.of(context).colorScheme.primary,
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.shopping_bag,
            size: 80,
            color: Colors.white,
          ),
          const SizedBox(height: 20),
          const Text(
            'StudentMarket',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 40),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(
                horizontal: 32,
                vertical: 12,
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const LoginScreen(),
                ),
              );
            },
            child: const Text('Otvori aplikaciju'),
          ),
        ],
      ),
    ),
  );
}

}
