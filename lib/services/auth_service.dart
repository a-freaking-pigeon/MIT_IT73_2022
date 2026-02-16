import 'package:firebase_auth/firebase_auth.dart';

enum UserRole { guest, user, admin }

class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static UserRole currentRole = UserRole.guest;

  static User? get currentUser => _auth.currentUser;

  static Future<void> login(String email, String password) async {
    await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    currentRole = UserRole.user;
  }

  static Future<void> register(String email, String password) async {
    await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    currentRole = UserRole.user;
  }

  static Future<void> logout() async {
    await _auth.signOut();
    currentRole = UserRole.guest;
  }
}
