import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:memory_notes_organizer/events/menu_events.dart';
import 'package:memory_notes_organizer/providers.dart';
import 'package:memory_notes_organizer/ui/logout/logout_page.dart';
import 'package:memory_notes_organizer/ui/search/search_panel.dart';
import 'package:memory_notes_organizer/ui/theme/theme_panel.dart';
import 'package:memory_notes_organizer/ui/todos/todo_main.dart';
import 'package:utilities/utilities.dart';

import 'main_screen_viewmodel.dart';

@RoutePage(name: 'MainScreenRoute')
class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  int _currentIndex = 0;
  late MainScreenViewModel viewModel;
  final _fabKey = GlobalKey<ExpandableFabState>();

  final List<Widget> _pages = [
    TodoMain(key: UniqueKey()),
    SearchPanel(key: UniqueKey()),
    ThemePanel(key: UniqueKey()),
    LogoutPage(key: UniqueKey()),
  ];


  @override
  void initState() {
    super.initState();
    setupListeners();
  }

  @override
  Widget build(BuildContext context) {
    var theme = ref.watch(themeProvider);
    viewModel = ref.read(mainScreenViewModelProvider);
    // ref.listen(configurationProvider, (previous, next) {
    //
    // });
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
          statusBarColor: theme.startGradientColor,
      ),
      child: Scaffold(
        floatingActionButtonLocation: ExpandableFab.location,
        floatingActionButton: _currentIndex == 0 ? ExpandableFab(
          key: _fabKey,
          distance: 70,
          type: ExpandableFabType.up,
          openButtonBuilder: RotateFloatingActionButtonBuilder(
            child: const Icon(Icons.add),
            fabSize: ExpandableFabSize.regular,
            foregroundColor: Colors.white,
            backgroundColor: Colors.blue,
            shape: const CircleBorder(),
          ),
          children: [
            FloatingActionButton.extended(
              heroTag: null,
              icon: const Icon(Icons.add),
              label: const Text('New File'),
              onPressed: () {
                _fabKey.currentState?.toggle();
                getMenuBus().fire(NewFileEvent());
              },
            ),
            FloatingActionButton.extended(
              heroTag: null,
              icon: const Icon(Icons.add),
              label: const Text('New Category'),
              onPressed: () {
                _fabKey.currentState?.toggle();
                getMenuBus().fire(NewCategoryEvent());
              },
            ),
            FloatingActionButton.extended(
              heroTag: null,
              icon: const Icon(Icons.add),
              label: const Text('New Todo'),
              onPressed: () {
                _fabKey.currentState?.toggle();
                getMenuBus().fire(NewTodoEvent());
              },
            ),
          ],
        ) : SizedBox.shrink(),
        body: SafeArea(
          child: IndexedStack(
            index: _currentIndex,
            children: _pages,
          ),
        ),
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: theme.startGradientColor,
            primaryColor: Colors.black,
          ),
          child: BottomNavigationBar(
            backgroundColor: theme.startGradientColor,
            selectedItemColor: theme.textColor,
            unselectedItemColor: theme.inverseTextColor,
            showUnselectedLabels: true,
            unselectedLabelStyle: getMediumTextStyle(Colors.black),
            selectedLabelStyle: getMediumTextStyle(Colors.blue),
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Todos'),
              BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
              BottomNavigationBarItem(
                icon: Icon(Icons.color_lens),
                label: 'Theme',
              ),
              BottomNavigationBarItem(icon: Icon(Icons.logout), label: 'Logout'),
            ],
          ),
        ),
      ),
    );
  }

  void setupListeners() {
    getMenuBus()
        .on<Event>()
        .listen((event) {
      switch (event.runtimeType) {
        case _ when event is TabSelectEvent:
          setState(() {
            _currentIndex = event.index;
          });
      }
    });
  }
}
