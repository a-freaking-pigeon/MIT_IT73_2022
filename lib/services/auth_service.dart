import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

enum UserRole { guest, user, admin }

class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  static UserRole currentRole = UserRole.guest;

  static User? get currentUser => _auth.currentUser;

  static Future<void> login(String email, String password) async {
    final credential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    final uid = credential.user!.uid;

    final doc = await _db.collection('users').doc(uid).get();

    if (doc.exists) {
      final data = doc.data()!;
  
      if (data['isActive'] == false) {
        await _auth.signOut();
        throw Exception("Vaš nalog je deaktiviran.");
      }

      if (data['role'] == 'admin') {
        currentRole = UserRole.admin;
      } else {
        currentRole = UserRole.user;
      }
    }
  }

  static Future<void> register(String email, String password) async {
    final credential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final uid = credential.user!.uid;

    await _db.collection('users').doc(uid).set({
      'email': email,
      'role': 'user',
      'isActive': true,
    });
      currentRole = UserRole.user;
  }

  static Future<void> logout() async {
    await _auth.signOut();
    currentRole = UserRole.guest;
  }
}