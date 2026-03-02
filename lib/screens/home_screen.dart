import 'package:flutter/material.dart';

import '../models/item.dart';
import '../widgets/item_card.dart';
import '../services/auth_service.dart';
import '../services/item_service.dart';

import 'add_edit_screen.dart';
import 'admin_screen.dart';
import 'login_screen.dart';
import '../services/currency_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<double> exchangeRate;

  @override
  void initState() {
    super.initState();
    exchangeRate = CurrencyService.getRsdToEurRate();
  }

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
              onPressed: () async {
                await AuthService.logout();
                if (!context.mounted) return;

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
      body: FutureBuilder<double>(
        future: exchangeRate,
        builder: (context, rateSnapshot) {
          if (rateSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (rateSnapshot.hasError) {
            // fallback kurs ako API pukne
            return _buildContent(0.0085);
          }

          final rate = rateSnapshot.data ?? 0.0085;

          return _buildContent(rate);
        },
      ),
    );
  }

  Widget _buildContent(double rate) {
  return StreamBuilder<List<Item>>(
    stream: ItemService.getItems(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      }

      if (snapshot.hasError) {
        return const Center(
          child: Text('Greška pri učitavanju oglasa'),
        );
      }

      if (!snapshot.hasData || snapshot.data!.isEmpty) {
        return const Center(
          child: Text('Nema dostupnih oglasa'),
        );
      }

      final items = snapshot.data!;

      return ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ItemCard(
            item: items[index],
            exchangeRate: rate,
          );
        },
      );
    },
  );
}
}
