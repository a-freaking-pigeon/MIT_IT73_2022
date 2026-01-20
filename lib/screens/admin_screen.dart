import 'package:flutter/material.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Administracija'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Upravljanje korisnicima',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          _adminCard(
            title: 'Petar Petrović',
            subtitle: 'user@email.com',
          ),
          _adminCard(
            title: 'Administrator',
            subtitle: 'admin@email.com',
            isAdmin: true,
          ),

          const SizedBox(height: 32),

          const Text(
            'Upravljanje sadržaja',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          _adminCard(
            title: 'Knjiga iz MIT-a',
            subtitle: '1500 RSD',
          ),
          _adminCard(
            title: 'Polovni laptop',
            subtitle: '45000 RSD',
          ),
        ],
      ),
    );
  }

  Widget _adminCard({
    required String title,
    required String subtitle,
    bool isAdmin = false,
  }) {
    return Card(
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (!isAdmin)
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () {},
              ),
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
