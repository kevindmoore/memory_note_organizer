import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:utilities/utilities.dart';

import '../../viewmodels/main_screen_model.dart';
import '../main_functions.dart';

class FindRow extends ConsumerStatefulWidget {
  const FindRow({super.key});

  @override
  ConsumerState<FindRow> createState() => _FindRowState();
}

class _FindRowState extends ConsumerState<FindRow> {
  late MainFunctions mainFunctions;
  late MainScreenModel mainScreenModel;

  @override
  void initState() {
    mainFunctions = MainFunctions(mainFunctionCallback);
    super.initState();
  }

  void mainFunctionCallback(CallbackType type, Object? data) {
    // TODO - Do something with this?
    switch (type) {
      case CallbackType.add:
        break;
      case CallbackType.delete:
        break;
      case CallbackType.rename:
        break;
      case CallbackType.refresh:
        break;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    mainScreenModel = ref.watch(mainScreenModelProvider);
    mainFunctions.build(ref);
    if (usePhone(MediaQuery.of(context))) {
      return Container();
    }
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
              mainFunctions.showSearchDialog(context);
            },
            icon: Icon(
              Icons.search,
              color: mainScreenModel.themeColors.textColor,
            ),
          ),
          Text('Find',
              style: getMediumTextStyle(mainScreenModel.themeColors.textColor)),
          const Spacer(),
          Text('⌘F',
              style: getMediumTextStyle(mainScreenModel.themeColors.textColor)),
          const SizedBox(
            width: 12,
          ),
        ],
      );
  }
}
