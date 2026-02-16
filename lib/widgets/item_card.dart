import 'package:flutter/material.dart';
import '../models/item.dart';
import '../services/item_service.dart';
import '../services/auth_service.dart';

class ItemCard extends StatelessWidget {
  final Item item;

  const ItemCard({super.key, required this.item});

  bool _canDelete() {
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
      onLongPress: _canDelete()
          ? () async {
              final confirm = await showDialog<bool>(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text('Brisanje'),
                  content: const Text('Da li ste sigurni da želite da obrišete oglas?'),
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
                await ItemService.deleteItem(item.id);
              }
            }
          : null,
      child: Card(
        child: ListTile(
          title: Text(item.title),
          subtitle: Text('${item.price} RSD'),
        ),
      ),
    );
  }
}
