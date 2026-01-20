enum UserRole { guest, user, admin }

class AuthService {
  static UserRole currentRole = UserRole.guest;

  static void loginAsUser() {
    currentRole = UserRole.user;
  }

  static void loginAsAdmin() {
    currentRole = UserRole.admin;
  }

  static void logout() {
    currentRole = UserRole.guest;
  }
}
