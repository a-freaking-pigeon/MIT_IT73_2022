import 'package:flutter/material.dart';
import '../widgets/custom_input.dart';
import '../widgets/custom_button.dart';
import '../models/item.dart';

class AddEditScreen extends StatelessWidget {
  final Item? item;

  const AddEditScreen({super.key, this.item});

  @override
  Widget build(BuildContext context) {
    final bool isEdit = item != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Izmeni objavu' : 'Dodaj objavu'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            CustomInput(
              label: 'Naziv',
            ),
            const SizedBox(height: 16),
            CustomInput(
              label: 'Opis',
            ),
            const SizedBox(height: 16),
            CustomInput(
              label: 'Cena',
            ),
            const SizedBox(height: 24),
            CustomButton(
              text: isEdit ? 'Sačuvaj izmene' : 'Dodaj objavu',
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
