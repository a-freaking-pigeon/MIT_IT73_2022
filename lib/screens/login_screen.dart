import 'package:flutter/material.dart';
import '../widgets/custom_input.dart';
import '../widgets/custom_button.dart';
import 'register_screen.dart';
import 'home_screen.dart';
import '../services/auth_service.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Prijava'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Dobrodošli',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 32),

            const CustomInput(
              label: 'Email',
            ),
            const SizedBox(height: 16),

            const CustomInput(
              label: 'Lozinka',
              isPassword: true,
            ),
            const SizedBox(height: 24),

            CustomButton(
              text: 'Prijava',
              onPressed: () {          
                AuthService.loginAsUser();

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomeScreen(),
                  ),
                );
              },
            ),

            const SizedBox(height: 16),

            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RegisterScreen(),
                  ),
                );
              },
              child: const Text(
                "Nemate nalog? Registrujte se ovde",
              ),
            ),

            TextButton(
              onPressed: () {
                AuthService.currentRole = UserRole.guest;

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const HomeScreen(),
                  ),
                );
              },
              child: const Text(
                'Nastavi kao gost',
              ),
            ),

            TextButton(
              onPressed: () {
                AuthService.loginAsAdmin();

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const HomeScreen(),
                  ),
                );
              },
              child: const Text(
                'Admin',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
