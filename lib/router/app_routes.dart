import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:memory_notes_organizer/providers.dart';
import 'package:memory_notes_organizer/ui/login.dart';
import 'package:memory_notes_organizer/ui/main/main_screen.dart';
import 'package:memory_notes_organizer/ui/main/main_screen_viewmodel.dart';

part 'app_routes.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  final Ref ref;

  AppRouter(this.ref);

  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      path: '/',
      initial: true,
      page: MainScreenRoute.page,
      children: [],
    ),
    AutoRoute(path: '/login', page: LoginRoute.page),
  ];
  @override
  late final List<AutoRouteGuard> guards = [
    AutoRouteGuard.simple((resolver, router) {
      MainScreenViewModel viewModel = ref.read(mainScreenViewModelProvider);

      if (viewModel.isLoggedIn() || resolver.routeName == LoginRoute.name) {
        // we continue navigation
        resolver.next();
      } else {
        // else we navigate to the Login page so we get authenticated

        // tip: use resolver.redirect to have the redirected route
        // automatically removed from the stack when the resolver is completed
        resolver.redirect(
          LoginRoute(onResult: (didLogin) => resolver.next(didLogin)),
        );
      }
    }),
    // add more guards here
  ];
}
