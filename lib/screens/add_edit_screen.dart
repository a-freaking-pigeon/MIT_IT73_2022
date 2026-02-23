import 'package:devecerski_it73_2022/services/auth_service.dart';
import 'package:devecerski_it73_2022/services/item_service.dart';
import 'package:flutter/material.dart';
import '../widgets/custom_input.dart';
import '../widgets/custom_button.dart';
import '../models/item.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AddEditScreen extends StatefulWidget {
  final Item? item;
  final bool readOnly;

  const AddEditScreen({super.key, this.item, this.readOnly = false,});

  @override
  State<AddEditScreen> createState() => _AddEditScreenState();
}

class _AddEditScreenState extends State<AddEditScreen> {
  File? selectedImage;
  final ImagePicker _picker = ImagePicker();
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

  Future<void> pickImage() async {
  final picked = await _picker.pickImage(source: ImageSource.gallery);

  if (picked != null) {
    setState(() {
      selectedImage = File(picked.path);
    });
  }
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
            const SizedBox(height: 24),

            const SizedBox(height: 16),

            GestureDetector(
              onTap: widget.readOnly ? null : pickImage,
              child: Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: selectedImage != null
                    ? Image.file(selectedImage!, fit: BoxFit.cover)
                    : (widget.item?.imageUrl != null &&
                            widget.item!.imageUrl.isNotEmpty)
                        ? Image.network(
                            widget.item!.imageUrl,
                            fit: BoxFit.cover,
                          )
                        : const Center(
                            child: Text('Dodajte sliku'),
                          ),
              ),
            ),

            CustomButton(
              text: isEdit ? 'Sačuvaj izmene' : 'Dodaj objavu',
              onPressed: () async {
                  String imageUrl = widget.item?.imageUrl ?? '';

                  if (selectedImage != null) {
                    final fileName = DateTime.now().millisecondsSinceEpoch.toString();

                    final ref = FirebaseStorage.instance
                        .ref()
                        .child('items')
                        .child(fileName);

                    await ref.putFile(selectedImage!);

                    imageUrl = await ref.getDownloadURL();
                  }

                final item = Item(
                  id: widget.item?.id ?? '',
                  title: titleController.text,
                  description: descriptionController.text,
                  price: double.tryParse(priceController.text) ?? 0,
                  imageUrl: imageUrl,
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
