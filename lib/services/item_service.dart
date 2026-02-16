import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/item.dart';

class ItemService {
  static final _db = FirebaseFirestore.instance;

  static Stream<List<Item>> getItems() {
    return _db.collection('items').snapshots().map(
      (snapshot) {
        return snapshot.docs
            .map((doc) => Item.fromFirestore(doc.id, doc.data()))
            .toList();
      },
    );
  }

  static Future<void> addItem(Item item) async {
    await _db.collection('items').add(item.toFirestore());
  }

  static Future<void> updateItem(Item item) async {
    await _db.collection('items').doc(item.id).update(item.toFirestore());
  }

  static Future<void> deleteItem(String id) async {
    await _db.collection('items').doc(id).delete();
  }
}
