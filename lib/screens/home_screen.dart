import 'package:flutter/material.dart';

import '../models/item.dart';
import '../widgets/item_card.dart';
import '../services/auth_service.dart';

import 'add_edit_screen.dart';
import 'admin_screen.dart';
import 'login_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // Fejk oglasi
  final List<Item> items = const [
    Item(
      title: 'Knjiga iz MIT-a',
      description: 'Odlično stanje, korišćena jednu godinu',
      price: 1500,
      imageUrl: 'https://picsum.photos/200/200?1',
    ),
    Item(
      title: 'Polovni laptop',
      description: 'i5 procesor, 8GB RAM, SSD',
      price: 45000,
      imageUrl: 'https://picsum.photos/200/200?2',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Oglasi'),
        actions: [
          if (AuthService.currentRole == UserRole.admin)
            IconButton(
              icon: const Icon(Icons.admin_panel_settings),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const AdminScreen(),
                  ),
                );
              },
            ),
          if (AuthService.currentRole != UserRole.guest)
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                AuthService.logout();

                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const LoginScreen(),
                  ),
                  (route) => false,
                );
              },
            ),
        ],
      ),
      floatingActionButton:
          AuthService.currentRole == UserRole.guest
              ? null
              : FloatingActionButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const AddEditScreen(),
                      ),
                    );
                  },
                  child: const Icon(Icons.add),
                ),

      body: items.isEmpty
          ? const Center(
              child: Text(
                'Nema dostupnih oglasa',
                style: TextStyle(fontSize: 16),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: items.length,
              itemBuilder: (context, index) {
                return ItemCard(
                  item: items[index],
                );
              },
            ),
    );
  }
}
