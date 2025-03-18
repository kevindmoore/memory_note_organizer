
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme.freezed.dart';

const themeKey = 'ThemeKey';
enum Themes { seaFoam, softBlue, sunset, deepBlue, dark }

@freezed
abstract class ThemeColors with _$ThemeColors {
  const factory ThemeColors(
      {required Color startGradientColor,
      required Color endGradientColor,
      required Color textColor,
      required Color inverseTextColor,
      }) = _ThemeColors;
}

class ThemeManager extends StateNotifier<ThemeColors> {
  final SharedPreferences prefs;

  ThemeManager(this.prefs) : super(softBlueTheme) {
    if (prefs.containsKey(themeKey)) {
      final themeName = prefs.getString(themeKey);
      final theme =
          Themes.values.firstWhereOrNull((theme) => theme.name == themeName);
      if (theme != null) {
        setTheme(theme);
      }
    }
  }

  void setThemeColor(ThemeColors theme) {
    state = theme;
    var themeName = Themes.softBlue.name;
    if (theme == softBlueTheme) {
      themeName = Themes.softBlue.name;
    } else if (theme == sunsetTheme) {
      themeName = Themes.sunset.name;
    } else if (theme == deepBlueTheme) {
      themeName = Themes.deepBlue.name;
    } else if (theme == darkTheme) {
      themeName = Themes.dark.name;
    }
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: state.startGradientColor,
    ));
    prefs.setString(themeKey, themeName);
  }

  void setTheme(Themes theme) {
    switch (theme) {
      case Themes.seaFoam:
        state = seafoamTheme;
        break;
      case Themes.softBlue:
        state = softBlueTheme;
        break;
      case Themes.sunset:
        state = sunsetTheme;
        break;
      case Themes.deepBlue:
        state = deepBlueTheme;
        break;
      case Themes.dark:
        state = darkTheme;
        break;
    }
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: state.startGradientColor,
    ));
    prefs.setString(themeKey, theme.name);
  }
}

ThemeColors seafoamTheme = const ThemeColors(
    startGradientColor: Color(0xFFACD7FE), endGradientColor: Color(0xFFCEF5C7), textColor: Colors.white, inverseTextColor: Colors.black);

ThemeColors deepBlueTheme = const ThemeColors(
    startGradientColor: Color(0xFF2C93F1), endGradientColor: Color(0xFF1465AE), textColor: Colors.white, inverseTextColor: Colors.black);

ThemeColors softBlueTheme = const ThemeColors(
    startGradientColor: Color(0xFFC7D3F3), endGradientColor: Color(0xFFA1BAF6), textColor: Colors.white, inverseTextColor: Colors.black);
ThemeColors sunsetTheme = const ThemeColors(
    startGradientColor: Color(0xFFF9B9B9), endGradientColor: Color(0xFFFDC27D), textColor: Colors.white, inverseTextColor: Colors.black);
ThemeColors darkTheme = const ThemeColors(
    startGradientColor: Color(0xFF545454), endGradientColor: Color(0xFF232323), textColor: Colors.white, inverseTextColor: Colors.black);
