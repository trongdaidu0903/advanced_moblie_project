import 'package:flutter/material.dart';
import 'package:myapp_lettutors/models/languages/lang_vi.dart';
import 'package:myapp_lettutors/models/languages/language.dart';

class AppProvider extends ChangeNotifier {
  Language language = Vietnamese();
  ThemeMode themeMode = ThemeMode.light;

  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  void setLanguage(Language language) {
    this.language = language;
    notifyListeners();
  }

  void toggleTheme(int i) {
    switch (i) {
      case 0:
        themeMode = ThemeMode.light;
        _isDarkMode = false;
        break;
      case 1:
        themeMode = ThemeMode.dark;
        _isDarkMode = true;
        break;
      case 2:
        themeMode = ThemeMode.system;
        _isDarkMode = false;
        break;
      default:
        themeMode = ThemeMode.light;
        break;
    }
  }

  void setTheme(int i) {
    switch (i) {
      case 0:
        themeMode = ThemeMode.light;
        _isDarkMode = false;
        break;
      case 1:
        themeMode = ThemeMode.dark;
        _isDarkMode = true;
        break;
      case 2:
        themeMode = ThemeMode.system;
        _isDarkMode = false;
        break;
      default:
        themeMode = ThemeMode.light;
        break;
    }
  }
}
