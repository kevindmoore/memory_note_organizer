import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:memory_notes_organizer/ui/todos/todo_actions.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supa_manager/supa_manager.dart';
import 'package:memory_notes_organizer/logs/log_container.dart';
import 'package:memory_notes_organizer/models/current_todo_state.dart';
import 'package:memory_notes_organizer/models/node.dart';
import 'package:memory_notes_organizer/models/todos.dart';
import 'package:memory_notes_organizer/repository/todo_repository.dart';
import 'package:memory_notes_organizer/router/app_routes.dart';
import 'package:memory_notes_organizer/theme/theme.dart';
import 'package:memory_notes_organizer/todos/todo_manager.dart';
import 'package:memory_notes_organizer/tree/current_todo_state_provider.dart';
import 'package:memory_notes_organizer/ui/dialogs/dialog_state.dart';
import 'package:memory_notes_organizer/ui/main/main_screen_viewmodel.dart';
import 'package:memory_notes_organizer/ui/menus.dart';
import 'package:memory_notes_organizer/ui/todos/tree/tree_viewmodel.dart';
import 'package:utilities/utilities.dart';

part 'providers.g.dart';

final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

@Riverpod(keepAlive: true)
TodoActions todoActions(Ref ref) => TodoActions(ref);

@Riverpod(keepAlive: true)
AppRouter appRouter(Ref ref) => AppRouter(ref);

@Riverpod(keepAlive: true)
MainScreenViewModel mainScreenViewModel(Ref ref) => MainScreenViewModel(ref);

@Riverpod(keepAlive: true)
TreeViewModel treeViewModel(Ref ref) => TreeViewModel(ref);

@Riverpod(keepAlive: true)
MenuManager menuManager(Ref ref) => MenuManager(ref);

@Riverpod(keepAlive: true)
LogContainer logContainer(Ref ref) => LogContainer();

@Riverpod(keepAlive: true)
EventBus searchBus(Ref ref) => EventBus();

@Riverpod(keepAlive: true)
EventBus eventBus(Ref ref) => EventBus();

late Configuration configuration;
final configurationProvider = Provider<Configuration>((ref) {
  return configuration;
});

final configurationLoginStateProvider = Provider.family<LoginStateNotifier, Configuration>((
  ref,
  configuration,
) {
  return configuration.loginStateNotifier;
});

final themeProvider = StateNotifierProvider<ThemeManager, ThemeColors>((ref) {
  return ThemeManager(globalSharedPreferences);
});

final logInStateProvider = ChangeNotifierProvider<LoginStateNotifier>((ref) {
  return ref.read(configurationProvider).loginStateNotifier;
});

final searchTextStateProvider = StateProvider<String>((ref) {
  return '';
});

final supaBaseDatabaseProvider = Provider.family<SupaDatabaseManager, Configuration>((
  ref,
  configuration,
) {
  return configuration.supaDatabaseRepository;
});

LoginStateNotifier getLoginStateNotifier(Ref ref) {
  return ref.read(configurationProvider).loginStateNotifier;
}

SupaDatabaseManager getSupaDatabaseManager(Ref ref) {
  return ref.read(configurationProvider).supaDatabaseRepository;
}

SupaAuthManager getSupaAuthManager(WidgetRef ref) {
  return ref.read(configurationProvider).supaAuthManager;
}

SupaAuthManager getProviderSupaAuthManager(Ref ref) {
  return ref.read(configurationProvider).supaAuthManager;
}

SupaAuthManager getChangeProviderSupaAuthManager(Ref ref) {
  return ref.read(configurationProvider).supaAuthManager;
}

@Riverpod(keepAlive: true)
DialogState dialogState(Ref ref) => DialogState();

class NavigationIndex extends Notifier<int> {
  @override
  int build() {
    return 0;
  }

  void setIndex(int index) {
    state = index;
  }

  int getIndex() => state;
}

final navigationProvider = NotifierProvider<NavigationIndex, int>(() {
  return NavigationIndex();
});

final todoManagerProvider = ChangeNotifierProvider<TodoManager>((ref) {
  return TodoManager(ref);
});

final todoRepositoryProvider = ChangeNotifierProvider<TodoRepository>((ref) {
  final todoManager = ref.read(todoManagerProvider);
  // final localDatabase = ref.read(localDatabaseProvider);
  final databaseRepository = getSupaDatabaseManager(ref);
  return TodoRepository(
    ref: ref,
    todoManager: todoManager,
    // localRepo: localDatabase,
    databaseRepository: databaseRepository,
  );
});

final currentTodoStateProvider = StateNotifierProvider<CurrentTodoStateProvider, CurrentTodoState>((
  ref,
) {
  return CurrentTodoStateProvider(ref, CurrentTodoState());
});

class CurrentFilesNotifier extends Notifier<List<TodoFile>> {
  @override
  List<TodoFile> build() {
    return [];
  }

  void setTodoFiles(List<TodoFile> todoFiles) {
    state = todoFiles;
  }

  void reset() {
    state = [];
  }

  List<TodoFile> getTodoFiles() => state;
}

final currentFilesProvider = NotifierProvider<CurrentFilesNotifier, List<TodoFile>>(() {
  return CurrentFilesNotifier();
});

class CurrentlySelectedNodeNotifier extends Notifier<Node?> {
  @override
  Node? build() {
    return null;
  }

  void setSelectedNode(Node? node) {
    state = node;
  }

  Node? getSelectedNode() => state;
}

final currentlySelectedNodeProvider = NotifierProvider<CurrentlySelectedNodeNotifier, Node?>(() {
  return CurrentlySelectedNodeNotifier();
});

extension ProviderExtensions on ConsumerState {
  List<TodoFile> getFiles() => ref.read(currentFilesProvider);

  Node? getSelectedNode() => ref.read(currentlySelectedNodeProvider);

  CurrentTodoState getCurrentTodoState() => ref.read(currentTodoStateProvider);

  CurrentTodoStateProvider getTodoStateProvider() => ref.read(currentTodoStateProvider.notifier);

  EventBus getSearchBus() => ref.read(searchBusProvider);

  EventBus getMenuBus() => ref.read(eventBusProvider);

  TodoRepository getTodoRepository() => ref.read(todoRepositoryProvider);

  LoginStateNotifier getLoginNotifier() => ref.read(configurationProvider).loginStateNotifier;
}
