import 'package:flutter/material.dart';
import '../models/item.dart';
import '../screens/add_edit_screen.dart';
import '../services/auth_service.dart';



class ItemCard extends StatelessWidget {
  final Item item;

  const ItemCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            item.imageUrl,
            width: 56,
            height: 56,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(item.title),
        subtitle: Text(item.description),
        trailing: Text('${item.price} RSD'),
        onTap: () {
          if (AuthService.currentRole == UserRole.guest) {
            showDialog(
              context: context,
              builder: (context) => const AlertDialog(
                title: Text('Pristup odbijen'),
                content: Text('Prijavite se da bi mogli da vršite izmene'),
              ),
            );
            return;
          }
        Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => AddEditScreen(item: item),
           ),
         );
      },
        onLongPress: () {
          if (AuthService.currentRole == UserRole.guest) {
            showDialog(
              context: context,
              builder: (context) => const AlertDialog(
                title: Text('Pristup odbijen'),
                content: Text('Prijavite se da bi mogli da vršite izmene'),
              ),
            );
            return;
          }
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
             title: const Text('Obriši oglas'),
             content: const Text('Da li ste sigurni da želite da obrišete oglas?'),
             actions: [
                TextButton(
                  onPressed: () {
                   Navigator.pop(context);
                  },
                 child: const Text('Otkaži'),
                ),
               TextButton(
                 onPressed: () {
                    Navigator.pop(context);
                  },
                 child: const Text(
                    'Obriši',
                    style: TextStyle(color: Colors.red),
                 ),
               ),
              ],
            ),
         );
        },
      ),
    );
  }
}
