import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Lang {
  static String _storedKey = 'storedLang';

  static Future saveLang(Locale locale) async {
    final String currentLanguageCode = locale.languageCode;
    final String shortLocaleCode = Intl.shortLocale(currentLanguageCode);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (locale == null) {
      prefs.remove(_storedKey);
    } else {
      prefs.setString(_storedKey, shortLocaleCode);
    }
    return;
  }

  static Future<Locale> getLang() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final langCode = prefs.getString(_storedKey);
    if (langCode == null) return null;
    return Locale(langCode);
  }
}