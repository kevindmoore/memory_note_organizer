import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:memory_notes_organizer/events/menu_events.dart';
import 'package:memory_notes_organizer/providers.dart';
import 'package:utilities/utilities.dart';

@RoutePage(name: 'LogoutPageRoute')
class LogoutPage extends ConsumerStatefulWidget {
  const LogoutPage({super.key});

  @override
  ConsumerState<LogoutPage> createState() => _LogoutPageState();
}

class _LogoutPageState extends ConsumerState<LogoutPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(onPressed: () {
        showAreYouSureDialog(context, () async {
          ref.read(eventBusProvider).fire(LogoutEvent());
        }, null);

      }, child: Text('Logout')),
    );
  }
}
