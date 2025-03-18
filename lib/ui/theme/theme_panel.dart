import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:memory_notes_organizer/providers.dart';
import 'package:memory_notes_organizer/theme/theme.dart';
import 'package:utilities/utilities.dart';


class ThemePanel extends ConsumerStatefulWidget {
  const ThemePanel({super.key});

  @override
  ConsumerState<ThemePanel> createState() => _ThemePanelState();
}

class _ThemePanelState extends ConsumerState<ThemePanel> {
  @override
  Widget build(BuildContext context) {
    var theme = ref.watch(themeProvider);
    return Container(
      decoration: createGradient(
        theme.startGradientColor,
        theme.endGradientColor,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Change Theme',
              style: titleBlackText,
            ),
            const Divider(),
            const SizedBox(
              height: 8,
            ),
            SizedBox(
              height: 110,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (BuildContext context, int index) =>
                    themeBoxByIndex(index),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget themeBoxByIndex(int index) {
    Widget selectedThemeBox;
    switch (index) {
      case 0:
        selectedThemeBox = createThemeBox('Seafoam', seafoamTheme);
        break;
      case 1:
        selectedThemeBox = createThemeBox('Soft Blue', softBlueTheme);
        break;
      case 2:
        selectedThemeBox = createThemeBox('Sunset', sunsetTheme);
        break;
      case 3:
        selectedThemeBox = createThemeBox('Deep blue', deepBlueTheme);
        break;
      case 4:
        selectedThemeBox = createThemeBox('Dark', darkTheme);
        break;
      default:
        selectedThemeBox = createThemeBox('Seafoam', seafoamTheme);
    }
    return selectedThemeBox;
  }

  Widget createThemeBox(String text, ThemeColors colors) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        ref.read(themeProvider.notifier).setThemeColor(colors);
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.bottomRight,
                      end: Alignment.topLeft,
                      colors: [
                        colors.startGradientColor,
                        colors.endGradientColor
                      ]),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                text,
                style: mediumBlackText,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
