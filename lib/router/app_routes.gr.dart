// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_routes.dart';

/// generated route for
/// [Login]
class LoginRoute extends PageRouteInfo<LoginRouteArgs> {
  LoginRoute({
    required ValueChanged<bool> onResult,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
         LoginRoute.name,
         args: LoginRouteArgs(onResult: onResult, key: key),
         initialChildren: children,
       );

  static const String name = 'LoginRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<LoginRouteArgs>();
      return Login(onResult: args.onResult, key: args.key);
    },
  );
}

class LoginRouteArgs {
  const LoginRouteArgs({required this.onResult, this.key});

  final ValueChanged<bool> onResult;

  final Key? key;

  @override
  String toString() {
    return 'LoginRouteArgs{onResult: $onResult, key: $key}';
  }
}

/// generated route for
/// [LogoutPage]
class LogoutPageRoute extends PageRouteInfo<void> {
  const LogoutPageRoute({List<PageRouteInfo>? children})
    : super(LogoutPageRoute.name, initialChildren: children);

  static const String name = 'LogoutPageRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const LogoutPage();
    },
  );
}

/// generated route for
/// [MainScreen]
class MainScreenRoute extends PageRouteInfo<void> {
  const MainScreenRoute({List<PageRouteInfo>? children})
    : super(MainScreenRoute.name, initialChildren: children);

  static const String name = 'MainScreenRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const MainScreen();
    },
  );
}
