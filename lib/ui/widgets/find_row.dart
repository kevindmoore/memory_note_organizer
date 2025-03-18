import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:memory_notes_organizer/providers.dart';
import 'package:memory_notes_organizer/ui/dialogs/search_dialog.dart';
import 'package:utilities/utilities.dart';


class FindRow extends ConsumerStatefulWidget {
  const FindRow({super.key});

  @override
  ConsumerState<FindRow> createState() => _FindRowState();
}

class _FindRowState extends ConsumerState<FindRow> {
  
  @override
  Widget build(BuildContext context) {
    if (usePhone(MediaQuery.of(context))) {
      return Container();
    }
    var theme = ref.read(themeProvider);
    return
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            width: 12,
          ),
          IconButton(
            tooltip: 'Search',
            onPressed: () {
              showSearchDialog(ref);
            },
            icon: Icon(
              Icons.search,
              color: theme.textColor,
            ),
          ),
          Text('Find',
              style: getMediumTextStyle(theme.textColor)),
          const Spacer(),
          Text('⌘F',
              style: getMediumTextStyle(theme.textColor)),
          const SizedBox(
            width: 12,
          ),
        ],
      );
  }
}
