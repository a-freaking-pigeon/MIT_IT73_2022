import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/item.dart';
import '../services/auth_service.dart';


class ItemService {
  static final _db = FirebaseFirestore.instance;

  static Stream<List<Item>> getItems() {
    return _db
        .collection('items')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Item.fromFirestore(doc.data(), doc.id))
            .toList());
  }

  static Future<void> addItem(Item item) async {
    await _db.collection('items').add(item.toMap());
  }

  static Future<void> updateItem(Item item) async {
    final currentUser = AuthService.currentUser;

    if (currentUser == null) return;

    if (currentUser.uid != item.ownerId &&
        AuthService.currentRole != UserRole.admin) {
      throw Exception("Nemate dozvolu za izmenu ovog oglasa.");
    }
    await _db.collection('items').doc(item.id).update(item.toMap());
  }

  static Future<void> deleteItem(Item item) async {
    final currentUser = AuthService.currentUser;

    if (currentUser == null) return;

    if (currentUser.uid != item.ownerId &&
        AuthService.currentRole != UserRole.admin) {
      throw Exception("Nemate dozvolu za brisanje ovog oglasa.");
    }
    await _db.collection('items').doc(item.id).delete();
  }
}