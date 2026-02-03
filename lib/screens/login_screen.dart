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
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(
        title: const Text('Prijava'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Dobrodošli',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24),

                const CustomInput(label: 'Mejl'),
                const SizedBox(height: 16),

                const CustomInput(
                  label: 'Lozinka',
                  isPassword: true,
                ),
                const SizedBox(height: 24),

                CustomButton(
                  text: 'Prijavi se',
                  onPressed: () {
                    AuthService.loginAsUser();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const HomeScreen(),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 12),

                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const RegisterScreen(),
                      ),
                    );
                  },
                  child: const Text("Nemate nalog? Registrujte se"),
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
                  child: const Text('Nastavite kao gost'),
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
        ),
      ),

    );
  }
}
