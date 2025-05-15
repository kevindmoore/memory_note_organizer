import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:memory_notes_organizer/providers.dart';

class ConnectivityManager {
  final Ref ref;
  bool isNetworkAvailable = true;
  late Connectivity _connectivity;
  late Stream<List<ConnectivityResult>> _connectivityStream;

  ConnectivityManager(this.ref) {
    _connectivity = Connectivity();
    _connectivityStream = _connectivity.onConnectivityChanged;
  }

  void startMonitoring() {
    _connectivityStream.listen((List<ConnectivityResult> results) {
      // Check if none of the results have connectivity
      if (results.isEmpty || results.contains(ConnectivityResult.none)) {
        isNetworkAvailable = false;
        // No network connection
      } else {
        isNetworkAvailable = true;
        // Network connection recovers, dismiss toast
      }
      ref.read(appStateNotifierProvider.notifier).setNetwork(isNetworkAvailable);
    });
  }
}