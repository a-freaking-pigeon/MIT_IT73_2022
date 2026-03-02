import 'package:flutter/material.dart';
import '../models/item.dart';
import '../services/item_service.dart';
import '../services/auth_service.dart';
import '../screens/add_edit_screen.dart';

class ItemCard extends StatelessWidget {
  final Item item;
  final double exchangeRate;

  const ItemCard({super.key, required this.item, required this.exchangeRate});

  bool _canDelete() {
    if (AuthService.currentRole == UserRole.admin) return true;

    if (AuthService.currentRole == UserRole.user &&
        AuthService.currentUser?.uid == item.ownerId) {
      return true;
    }

    return false;
  }

  bool _canEdit() {
  if (AuthService.currentRole == UserRole.admin) return true;

  if (AuthService.currentRole == UserRole.user &&
      AuthService.currentUser?.uid == item.ownerId) {
    return true;
  }

  return false;
}

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:() {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => AddEditScreen(
              item: item, 
              readOnly: !_canEdit()
              ),
          ),
        );
      },
      onLongPress: _canDelete()
          ? () async {
              final confirm = await showDialog<bool>(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text('Brisanje'),
                  content: const Text(
                      'Da li ste sigurni da želite da obrišete oglas?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: const Text('Otkaži'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: const Text('Obriši'),
                    ),
                  ],
                ),
              );

              if (confirm == true) {
                await ItemService.deleteItem(item);
              }
            }
          : null,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (item.imageUrl.isNotEmpty)
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    item.imageUrl,
                    height: 160,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              const SizedBox(height: 10),
              Text(
                item.title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(item.description),
              const SizedBox(height: 6),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${item.price} RSD',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Text(
                    '${(item.price * exchangeRate).toStringAsFixed(2)} EUR',
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}