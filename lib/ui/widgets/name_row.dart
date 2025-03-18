import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:memory_notes_organizer/providers.dart';
import 'package:utilities/utilities.dart';


class NameRow extends ConsumerStatefulWidget {
  const NameRow({super.key});

  @override
  ConsumerState<NameRow> createState() => _NameRowState();
}

class _NameRowState extends ConsumerState<NameRow> {
  @override
  Widget build(BuildContext context) {
    if (usePhone(MediaQuery.of(context))) {
      return Container();
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 40,
        decoration: createSimiRoundedBorder(),
        child: Row(
          children: [
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: AutoSizeText(
                getSupaAuthManager(ref).getUserEmail() ?? '',
                style: mediumBlackText,
              ),
            ),
            // const Spacer(),
            PopupMenuButton(
              icon: const Icon(Icons.more_vert),
              itemBuilder: (context) => [
                PopupMenuItem(
                  child: const Text('Change Theme'),
                  onTap: () {
                    setState(() {
                      // mainScreenModel.changeTheme = true;
                    });
                  },
                ),
                PopupMenuItem(
                  child: Row(
                    children: [
                      const Icon(Icons.logout),
                      Text(
                        'Log Out',
                        style: mediumBlackText,
                      )
                    ],
                  ),
                  onTap: () {
                    getSupaAuthManager(ref).logout();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
