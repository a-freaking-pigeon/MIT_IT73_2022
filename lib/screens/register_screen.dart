import 'package:flutter/material.dart';
import '../widgets/custom_input.dart';
import '../widgets/custom_button.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

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

            const CustomInput(
              label: 'Ime i prezime',
            ),
            const SizedBox(height: 16),

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
              text: 'Kreiranje naloga',
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
