import 'package:flutter/material.dart';
import '../widgets/custom_input.dart';
import '../widgets/custom_button.dart';
import '../services/auth_service.dart';
import 'home_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registracija'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Kreiranje naloga',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 32),

            CustomInput(
              label: 'Ime i prezime',
              controller: nameController,
            ),
            const SizedBox(height: 16),

            CustomInput(
              label: 'Mejl',
              controller: emailController,
            ),
            const SizedBox(height: 16),

            CustomInput(
              label: 'Lozinka',
              isPassword: true,
              controller: passwordController,
            ),
            const SizedBox(height: 24),

            CustomButton(
              text: 'Kreiraj nalog',
              onPressed: () async {
                try {
                  await AuthService.register(
                    emailController.text.trim(),
                    passwordController.text.trim(),
                  );

                  if (!mounted) return;

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const HomeScreen(),
                    ),
                  );
                } catch (e) {
                  if (!mounted) return;

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Registracija nije uspela'),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
