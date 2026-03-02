import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/item_service.dart';
import '../models/item.dart';
import 'add_edit_screen.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Administracija'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Registrovani korisnici',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const CircularProgressIndicator();
                }

                final users = snapshot.data!.docs;

                if (users.isEmpty) {
                  return const Text('Nema korisnika');
                }

                return Column(
                  children: users.map((doc) {
                    final data = doc.data() as Map<String, dynamic>;
                    final role = data['role'] ?? 'user';
                    final isActive = data['isActive'] ?? true;

                    return Card(
                      child: ListTile(
                        title: Text(data['email'] ?? ''),
                        subtitle: Text(
                          'Role: $role | ${isActive ? "Aktivan" : "Deaktiviran"}',
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [

                            /// Promena role
                            IconButton(
                              icon: const Icon(Icons.swap_horiz),
                              tooltip: 'Promeni ulogu',
                              onPressed: () async {
                                final newRole =
                                    role == 'admin' ? 'user' : 'admin';

                                await FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(doc.id)
                                    .update({'role': newRole});
                              },
                            ),

                            /// Aktivacija / deaktivacija
                            IconButton(
                              icon: Icon(
                                isActive
                                    ? Icons.block
                                    : Icons.check_circle,
                                color: isActive
                                    ? Colors.red
                                    : Colors.green,
                              ),
                              tooltip: isActive
                                  ? 'Deaktiviraj'
                                  : 'Aktiviraj',
                              onPressed: () async {
                                await FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(doc.id)
                                    .update({'isActive': !isActive});
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                );
              },
            ),
            const SizedBox(height: 32),
            const Text(
              'Svi oglasi',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            StreamBuilder<List<Item>>(
              stream: ItemService.getItems(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const CircularProgressIndicator();
                }

                final items = snapshot.data!;

                if (items.isEmpty) {
                  return const Text('Nema oglasa');
                }

                return Column(
                  children: items.map((item) {
                    return Card(
                      child: ListTile(
                        title: Text(item.title),
                        subtitle: Text('${item.price} RSD'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        AddEditScreen(item: item),
                                  ),
                                );
                              },
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                              onPressed: () async {
                                await ItemService.deleteItem(item);
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}