import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:utilities/utilities.dart';

import '../../providers.dart';
import '../../viewmodels/main_screen_model.dart';

NavigationRailDestination slideInNavigationItem({
  required double begin,
  required AnimationController controller,
  required IconData icon,
  required String label,
}) {
  return NavigationRailDestination(
    icon: SlideTransition(
      position: Tween<Offset>(
        begin: Offset(begin, 0),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeInOutCubic),
      ),
      child: Icon(icon),
    ),
    label: Text(label),
  );
}


class Rails extends ConsumerStatefulWidget {
  const Rails({super.key});

  @override
  ConsumerState<Rails> createState() => _RailsState();
}

class _RailsState extends ConsumerState<Rails> with TickerProviderStateMixin {
  late MainScreenModel mainScreenModel;
  late AnimationController _listIconSlideController;
  late AnimationController _searchIconSlideController;
  late AnimationController _themeIconSlideController;
  late AnimationController _logoutIconSlideController;

  @override
  void initState() {
    _listIconSlideController = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    )..forward();
    _searchIconSlideController = AnimationController(
      duration: const Duration(milliseconds: 120),
      vsync: this,
    )..forward();
    _themeIconSlideController = AnimationController(
      duration: const Duration(milliseconds: 120),
      vsync: this,
    )..forward();
    _logoutIconSlideController = AnimationController(
      duration: const Duration(milliseconds: 140),
      vsync: this,
    )..forward();
    super.initState();
  }

  @override
  void dispose() {
    _listIconSlideController.dispose();
    _searchIconSlideController.dispose();
    _themeIconSlideController.dispose();
    _logoutIconSlideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    mainScreenModel = ref.watch(mainScreenModelProvider);
    final navigationIndexProvider = ref.watch(navigationProvider.notifier);
    return Container(
      decoration: createGradient(mainScreenModel.themeColors.startGradientColor,
          mainScreenModel.themeColors.endGradientColor),
      child: AdaptiveScaffold.standardNavigationRail(
        destinations: getRailNavigations(),
        onDestinationSelected: (int index) {
          setState(() {
            navigationIndexProvider.setIndex(index);
          });
        },
        selectedIndex: navigationIndexProvider.getIndex(),
        backgroundColor: mainScreenModel.themeColors.endGradientColor,
      ),
    );
  }

  List<NavigationRailDestination> getRailNavigations() {
    return [
      slideInNavigationItem(
        begin: -1,
        controller: _listIconSlideController,
        icon: Icons.home,
        label: 'Lists',
      ),
      slideInNavigationItem(
        begin: -1,
        controller: _searchIconSlideController,
        icon: Icons.search,
        label: 'Search',
      ),
      slideInNavigationItem(
        begin: -1,
        controller: _searchIconSlideController,
        icon: Icons.color_lens,
        label: 'Theme',
      ),
      slideInNavigationItem(
        begin: -1,
        controller: _logoutIconSlideController,
        icon: Icons.logout,
        label: 'Logout',
      ),
    ];
  }

  List<NavigationDestination> getNavigations() {
    return const [
      NavigationDestination(icon: Icon(Icons.home), label: 'Lists'),
      NavigationDestination(icon: Icon(Icons.search), label: 'Search'),
      NavigationDestination(icon: Icon(Icons.color_lens), label: 'Theme'),
      NavigationDestination(icon: Icon(Icons.logout), label: 'Logout'),
    ];
  }

}
