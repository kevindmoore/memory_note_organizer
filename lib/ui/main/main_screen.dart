import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:memory_notes_organizer/events/menu_events.dart';
import 'package:memory_notes_organizer/providers.dart';
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
  final List<Widget> _pages = [
    const TodoMain(),
    const SearchPanel(),
    const ThemePanel(),
    const Center(child: Text('Logout')),
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
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
          statusBarColor: theme.startGradientColor,
      ),
      child: Scaffold(
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
