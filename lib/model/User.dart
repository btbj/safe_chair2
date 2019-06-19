import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class User {
  static final String _storedKey = 'storedUser';

  final String token;
  final String username;

  User({
    this.token,
    this.username,
  });

  static String stringfy(User user) {
    final Map<String, String> map = {
      'token': user.token,
      'username': user.username,
    };
    return jsonEncode(map);
  }

  static User parse(String userString) {
    if (userString == null) return null;
    try {
      final Map<String, dynamic> userMap = jsonDecode(userString);
      return User(
        token: userMap['token'],
        username: userMap['username'],
      );
    } catch (e) {
      print('parse user error');
      return null;
    }
  }

  static Future saveUser(User user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (user == null) {
      await prefs.remove(_storedKey);
      print('remove user');
    } else {
      await prefs.setString(_storedKey, User.stringfy(user));
    }
    return;
  }

  static Future<User> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String userMapString = prefs.getString(_storedKey);
    return User.parse(userMapString);
  }
}