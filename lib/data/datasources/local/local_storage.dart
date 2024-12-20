import 'package:shared_preferences/shared_preferences.dart';
import 'package:sekolator/domain/entities/user.dart';
import 'dart:convert';

class LocalStorage {
  static Future<void> saveUserData(User user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user', jsonEncode({
      'email': user.email,
      'username': user.username,
    }));
  }

  static Future<User?> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    String? userJson = prefs.getString('user');
    if (userJson != null) {
      Map<String, dynamic> userMap = jsonDecode(userJson);
      return User(
        email: userMap['email'],
        username: userMap['username'],
      );
    }
    return null;
  }
}
