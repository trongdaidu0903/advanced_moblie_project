import 'package:flutter/material.dart';
import 'package:myapp_lettutors/models/languages/lang_vi.dart';
import 'package:myapp_lettutors/models/languages/language.dart';

class AppProvider extends ChangeNotifier {
  Language language = Vietnamese();

  ThemeData themeLight = ThemeData.light().copyWith(
      useMaterial3: true,
      primaryColor: Colors.blue,
      textTheme: TextTheme(
        displayLarge: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: Colors.blue[600],
            letterSpacing: 1.1),
        displayMedium: TextStyle(
          fontSize: 26,
          fontWeight: FontWeight.w700,
          color: Colors.blue[600],
        ),
        displaySmall: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        headlineMedium: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
        bodyLarge: TextStyle(
            fontSize: 17.0,
            fontWeight: FontWeight.w600,
            color: Colors.blue[600]),
        bodyMedium: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w500,
            color: Colors.grey[900]),
      ));

  ThemeData themeDark = ThemeData.dark().copyWith(
      useMaterial3: true,
      primaryColor: Colors.blue,
      textTheme: TextTheme(
        displayLarge: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: Colors.blue[600],
            letterSpacing: 1.1),
        displayMedium: TextStyle(
          fontSize: 26,
          fontWeight: FontWeight.w700,
          color: Colors.blue[600],
        ),
        displaySmall: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        headlineMedium: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
        bodyLarge: TextStyle(
            fontSize: 17.0,
            fontWeight: FontWeight.w600,
            color: Colors.blue[600]),
        bodyMedium: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w500,
            color: Colors.grey[900]),
      ));

  bool _isDarkMode = false;

  ThemeData theme = ThemeData.light().copyWith(
      useMaterial3: true,
      primaryColor: Colors.blue,
      textTheme: TextTheme(
        displayLarge: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: Colors.blue[600],
            letterSpacing: 1.1),
        displayMedium: TextStyle(
          fontSize: 26,
          fontWeight: FontWeight.w700,
          color: Colors.blue[600],
        ),
        displaySmall: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        headlineMedium: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
        bodyLarge: TextStyle(
            fontSize: 17.0,
            fontWeight: FontWeight.w600,
            color: Colors.blue[600]),
        bodyMedium: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w500,
            color: Colors.grey[900]),
      ));

  bool get isDarkMode => _isDarkMode;

  void setLanguage(Language language) {
    this.language = language;
    notifyListeners();
  }

  void setTheme(int i) {
    switch (i) {
      case 0:
        theme = themeLight;
        _isDarkMode = false;
        break;
      case 1:
        theme = themeDark;
        _isDarkMode = true;
        break;
      case 2:
        theme = themeLight;
        _isDarkMode = false;
        break;
      default:
        theme = themeLight;
        break;
    }
  }
}
