import 'package:devecerski_it73_2022/services/auth_service.dart';
import 'package:devecerski_it73_2022/services/item_service.dart';
import 'package:flutter/material.dart';
import '../widgets/custom_input.dart';
import '../widgets/custom_button.dart';
import '../models/item.dart';

class AddEditScreen extends StatefulWidget {
  final Item? item;
  final bool readOnly;

  const AddEditScreen({
    super.key,
    this.item,
    this.readOnly = false,
  });

  @override
  State<AddEditScreen> createState() => _AddEditScreenState();
}

class _AddEditScreenState extends State<AddEditScreen> {
  late final TextEditingController titleController;
  late final TextEditingController descriptionController;
  late final TextEditingController priceController;
  late final TextEditingController imageUrlController;

  @override
  void initState() {
    super.initState();

    titleController =
        TextEditingController(text: widget.item?.title ?? '');

    descriptionController =
        TextEditingController(text: widget.item?.description ?? '');

    priceController = TextEditingController(
      text: widget.item?.price.toString() ?? '',
    );

    imageUrlController =
        TextEditingController(text: widget.item?.imageUrl ?? '');
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    imageUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isEdit = widget.item != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Izmeni objavu' : 'Dodaj objavu'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            CustomInput(
              label: 'Naziv',
              controller: titleController,
              enabled: !widget.readOnly,
            ),
            const SizedBox(height: 16),

            CustomInput(
              label: 'Opis',
              controller: descriptionController,
              enabled: !widget.readOnly,
            ),
            const SizedBox(height: 16),

            CustomInput(
              label: 'Cena',
              controller: priceController,
              enabled: !widget.readOnly,
            ),
            const SizedBox(height: 16),

            CustomInput(
              label: 'URL slike (opciono)',
              controller: imageUrlController,
              enabled: !widget.readOnly,
            ),
            const SizedBox(height: 24),

            if (imageUrlController.text.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  imageUrlController.text,
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Text('Neispravan URL slike');
                  },
                ),
              ),

            const SizedBox(height: 24),

            if (!widget.readOnly)
              CustomButton(
                text: isEdit ? 'Sačuvaj izmene' : 'Dodaj objavu',
                onPressed: () async {
                  final item = Item(
                    id: widget.item?.id ?? '',
                    title: titleController.text,
                    description: descriptionController.text,
                    price:
                        double.tryParse(priceController.text) ?? 0,
                    imageUrl: imageUrlController.text.trim(),
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