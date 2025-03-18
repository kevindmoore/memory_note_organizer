import 'package:colorize_lumberdash/colorize_lumberdash.dart';
import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lumberdash/lumberdash.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supa_manager/supa_manager.dart';
import 'package:memory_notes_organizer/providers.dart';
import 'package:memory_notes_organizer/ui/keyboard_handler.dart';
import 'package:utilities/utilities.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  putLumberdashToWork(withClients: [ColorizeLumberdash()]);
  // To load the .env file contents into dotenv.
  // NOTE: fileName defaults to .env and can be omitted in this case.
  // Ensure that the filename corresponds to the path in step 1 and 2.
  await dotenv.load(fileName: '.env');

  globalSharedPreferences = await SharedPreferences.getInstance();
  final secrets = await SecretLoader(secretPath: 'assets/secrets.json').load();
  configuration = Configuration();
  await configuration.initialize(secrets.url, secrets.apiKey, secrets.apiSecret);

  if (isDesktop()) {
    await DesktopWindow.setWindowSize(const Size(700, 600));

    await DesktopWindow.setMinWindowSize(const Size(700, 600));
    // await DesktopWindow.setMaxWindowSize(Size.infinite);
  }
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends ConsumerStatefulWidget {
  const MainApp({super.key});

  @override
  ConsumerState<MainApp> createState() => _MainAppState();
}

class _MainAppState extends ConsumerState<MainApp> {
  var initialized = false;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (initialized) {
        return;
      }
      final auth = getSupaAuthManager(ref);
      await auth.loadUser();
      initialized = true;
    });
    final router = ref.watch(appRouterProvider);
    if (isDesktop()) {
      return KeyboardHandler(
        child: PlatformMenuBar(
          menus: ref.read(menuManagerProvider).createMenus(),
          child: MaterialApp.router(
            scaffoldMessengerKey: scaffoldMessengerKey,
            routerConfig: router.config(),
            title: 'Note Master',
            debugShowCheckedModeBanner: false,
            // theme: createTheme(),
          ),
        ),
      );
    } else {
      return MaterialApp.router(
        routerConfig: router.config(),
        title: 'Note Master',
        debugShowCheckedModeBanner: false,
        // theme: createTheme(),
      );
    }
  }
}
