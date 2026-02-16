import 'package:devecerski_it73_2022/services/auth_service.dart';
import 'package:devecerski_it73_2022/services/item_service.dart';
import 'package:flutter/material.dart';
import '../widgets/custom_input.dart';
import '../widgets/custom_button.dart';
import '../models/item.dart';

class AddEditScreen extends StatefulWidget {
  final Item? item;

  const AddEditScreen({super.key, this.item});

  @override
  State<AddEditScreen> createState() => _AddEditScreenState();
}

class _AddEditScreenState extends State<AddEditScreen> {
  late final TextEditingController titleController;
  late final TextEditingController descriptionController;
  late final TextEditingController priceController;

  @override
  void initState() {
    super.initState();

    titleController = TextEditingController(
      text: widget.item?.title ?? '',
    );
    descriptionController = TextEditingController(
      text: widget.item?.description ?? '',
    );
    priceController = TextEditingController(
      text: widget.item?.price.toString() ?? '',
    );
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isEdit = widget.item != null;

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
              controller: titleController,
            ),
            const SizedBox(height: 16),

            CustomInput(
              label: 'Opis',
              controller: descriptionController,
            ),
            const SizedBox(height: 16),

            CustomInput(
              label: 'Cena',
              controller: priceController,
            ),
            const SizedBox(height: 24),

            CustomButton(
              text: isEdit ? 'Sačuvaj izmene' : 'Dodaj objavu',
              onPressed: () async {
                final item = Item(
                  id: widget.item?.id ?? '',
                  title: titleController.text,
                  description: descriptionController.text,
                  price: double.tryParse(priceController.text) ?? 0,
                  imageUrl: widget.item?.imageUrl ?? 'https://picsum.photos/200',
                  ownerId: AuthService.currentUser!.uid,
                );

                if (isEdit) {
                  await ItemService.updateItem(item);
                } else {
                  await ItemService.addItem(item);
                }

                if (!context.mounted) return;
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
