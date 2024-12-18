import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/shared_model.dart';



class ThemeNotifier extends ChangeNotifier {
  bool _isDarkMode = false;
  bool _isSystemMode = true;

  bool get isDarkMode => _isDarkMode;

  bool get isSystemMode => _isSystemMode;
  final Brightness brightness;

  ThemeNotifier(this.brightness) {
    _loadFromPrefs(brightness);
  }

  void changeTheme({required bool isSystem, required bool isDarkMode}) {
    _isDarkMode = isDarkMode;
    _isSystemMode = isSystem;
    _saveToPrefs();
  }

  void _loadFromPrefs(Brightness brightness) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isDarkMode = brightness == Brightness.dark;
    if (prefs.getBool(SharedModel.themeIsSystem) == true ||
        prefs.getBool(SharedModel.themeIsSystem) == null) {
      prefs.setBool(SharedModel.theme, isDarkMode);
      prefs.setBool(SharedModel.themeIsSystem, true);
    }

    _isDarkMode = prefs.getBool(SharedModel.theme) ?? false;

    _isSystemMode = prefs.getBool(SharedModel.themeIsSystem) ?? true;
  }

  void _saveToPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(SharedModel.theme, _isDarkMode);
    prefs.setBool(SharedModel.themeIsSystem, _isSystemMode);
  }
}

class ThemeInheritedWidget extends InheritedWidget {
  final ThemeNotifier themeNotifier;

  const ThemeInheritedWidget(
      {super.key, required super.child, required this.themeNotifier});

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }

  static ThemeInheritedWidget? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ThemeInheritedWidget>();
  }
}
