class User {
  final int id;
  final String username;

  User({required this.id, required this.username});
}

class AuthManager {
  static User? _currentUser;

  static void loginUser(int userId, String username) {
    _currentUser = User(id: userId, username: username);
  }

  static User getCurrentUser() {
    if (_currentUser == null) {
      // Handle the case where there is no current user (e.g., show login screen)
      throw Exception('No current user. Please log in.');
    }
    return _currentUser!;
  }

  static bool isLoggedIn() {
    return _currentUser != null;
  }

  static void logoutUser() {
    _currentUser = null;
  }
}
