import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:memory_notes_organizer/events/menu_events.dart';
import 'package:utilities/utilities.dart';

import '../providers.dart';

class KeyboardHandler extends ConsumerWidget {
  final Widget child;

  const KeyboardHandler({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FocusableActionDetector(
      autofocus: true,
      shortcuts: createShortcuts(),
      actions: createActions(ref),
      child: child,
    );
  }

  Map<Type, Action<Intent>> createActions(WidgetRef ref) {
    final actions = <Type, Action<Intent>>{};
    actions[SearchIntent] = CallbackAction(onInvoke: (e) {
      ref.read(eventBusProvider).fire(ShowSearchEvent());
      return null;
    });
    //SearchAction();
    return actions;

  }

  Map<ShortcutActivator, Intent> createShortcuts() {
    final shortcuts = <ShortcutActivator, Intent>{};
    shortcuts.putIfAbsent(LogicalKeySet(getMetaKey(), LogicalKeyboardKey.keyF),
        () => SearchIntent());
    return shortcuts;
  }

  LogicalKeyboardKey getMetaKey() =>
      isMac() ? LogicalKeyboardKey.meta : LogicalKeyboardKey.control;

}

class SearchIntent extends Intent {}

class SearchAction extends CallbackAction<SearchIntent> {
  SearchAction() : super(onInvoke: searchCallback);
}

Object? searchCallback(SearchIntent intent) {
  log('searchCallback');
  return null;
}
