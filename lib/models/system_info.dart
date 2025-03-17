import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final systemInfoProvider = Provider<SystemInfo>((ref) {
  return SystemInfo();
});

enum Device {
  android,
  iOS,
  macOS,
  windows,
  web
}

enum ScreenWidth {
  narrow,
  wide
}
class SystemInfo {
  Device device = Device.android;
  ScreenWidth width = ScreenWidth.narrow;
  
  void setup(BuildContext context) {
    final shortestSize = MediaQuery.of(context).size.shortestSide;
    if (Platform.isAndroid) {
      device = Device.android;
    } else if (Platform.isIOS) {
      device = Device.iOS;
    } else if (Platform.isMacOS) {
      device = Device.macOS;
    } else if (Platform.isWindows) {
      device = Device.windows;
    } else if (kIsWeb) {
      device = Device.web;
    }
    if (shortestSize < 550) {
      width = ScreenWidth.narrow;
    } else {
      width = ScreenWidth.wide;
    }
  }

  bool showSystemTitleBar() {
    return width == ScreenWidth.narrow;
  }
}