import 'package:flutter/foundation.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

class AuthService extends ChangeNotifier {
  ParseUser? _user;

  ParseUser? get currentUser => _user;
  bool get isLoggedIn => _user != null;

  /// Restore previously logged-in session
  Future<void> restoreSession() async {
    final user = await ParseUser.currentUser() as ParseUser?;
    _user = user;
    notifyListeners();
  }

  /// Register a new user
  Future<ParseResponse> register(String email, String password) async {
    final user = ParseUser(email, password, email);
    final response = await user.signUp();

    if (response.success) {
      _user = response.result as ParseUser;
      notifyListeners();
    }

    return response;
  }

  /// Login existing user
  Future<ParseResponse> login(String email, String password) async {
    final user = ParseUser(email, password, email);
    final response = await user.login();

    if (response.success) {
      _user = response.result as ParseUser;
      notifyListeners();
    }

    return response;
  }

  /// Logout current user
  Future<void> logout() async {
    final user = await ParseUser.currentUser();
    if (user != null) {
      await user.logout();
    }
    _user = null;
    notifyListeners();
  }
}
