import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:memory_notes_organizer/providers.dart';

class MainScreenViewModel {
  final Ref ref;

  MainScreenViewModel(this.ref);

  bool isLoggedIn() {
    return getProviderSupaAuthManager(ref).isLoggedIn();
  }
}