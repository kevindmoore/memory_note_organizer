import 'package:flutter/material.dart';


Widget loadingWidget() {
  return const Center(child: CircularProgressIndicator());
}
/*
Widget createNewPopup(
    List<Widget> children) {
  return Stack(
    alignment: Alignment.topLeft,
    children: [
      Positioned(
        top: 8,
        right: 0,
        height: 10,
        width: 100,
        child: Row(
          children: [
            const Spacer(),
            SizedBox(
                width: 8,
                height: 8,
                child: CustomPaint(painter: Triangle(Colors.white))),
            const SizedBox(
              width: 20,
            )
          ],
        ),
      ),
      Card(
        child: SizedBox(
          height: 40,
          child: Row(
            children: children,
          ),
        ),
      ),
    ],
  );
}

Widget folderIcon(String newFolderName, VoidCallback newFolder) {
  return TextButton.icon(
    onPressed: () {
      newFolder();
    },
    icon: const Icon(
      Icons.folder,
      color: Colors.black,
    ),
    label: Text(
      newFolderName,
      style: getSmallTextStyle(Colors.black),
    ),
  );
}

Widget todoIcon(String newTodoName, VoidCallback newNote) {
  return TextButton.icon(
    onPressed: () {
      newNote();
    },
    icon: const Icon(
      Icons.note_add,
      color: Colors.black,
    ),
    label: Text(
      newTodoName,
      style: getSmallTextStyle(Colors.black),
    ),
  );
}

Widget createThemePanel(VoidCallback tapCallback) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Change theme',
          style: titleBlackText,
        ),
        const Divider(),
        const SizedBox(
          height: 8,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            createThemeBox('Seafoam', seafoamTheme, tapCallback),
            createThemeBox('Soft Blue', softBlueTheme, tapCallback),
            createThemeBox('Sunset', sunsetTheme, tapCallback),
            createThemeBox('Deep blue', deepBlueTheme, tapCallback),
            createThemeBox('Dark', darkTheme, tapCallback),
          ],
        )
      ],
    ),
  );
}

Widget createThemeBox(String text, ThemeColors colors, VoidCallback tapCallback) {
  return GestureDetector(
    behavior: HitTestBehavior.translucent,
    onTap: () {
      tapCallback();
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
*/