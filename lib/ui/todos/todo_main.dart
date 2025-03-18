import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multi_split_view/multi_split_view.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:memory_notes_organizer/ui/todos/tree/tree_widget.dart';
import 'package:memory_notes_organizer/ui/widgets/notes_panel.dart';

class TodoMain extends ConsumerStatefulWidget {
  const TodoMain({super.key});

  @override
  ConsumerState<TodoMain> createState() => _TodoMainState();
}

class _TodoMainState extends ConsumerState<TodoMain> {
  final MultiSplitViewController _controller = MultiSplitViewController();
  final PageController _pageController = PageController();
  final pageViewWidgets = [
    TreeWidget(),
    NotesPanel(),
  ];

  @override
  void initState() {
    super.initState();
    _controller.areas = [Area(data: 1, min: 360), Area(data: 2, flex: 1, min: 500)];
    _controller.addListener(_rebuild);
  }

  @override
  void dispose() {
    _pageController.dispose();
    _controller.removeListener(_rebuild);
    super.dispose();
  }

  void _rebuild() {
    setState(() {
      // rebuild to update empty text and buttons
    });
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveBreakpoints.builder(
      breakpoints: [
        const Breakpoint(start: 0, end: 450, name: MOBILE),
        const Breakpoint(start: 451, end: 800, name: TABLET),
        const Breakpoint(start: 801, end: 1920, name: DESKTOP),
        const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
      ],
      child: Builder(
        builder: (context) {
          return buildContent(context);
        }
      )
    );
  }

  Widget buildContent(BuildContext context) {
    if (ResponsiveBreakpoints.of(context).isDesktop || ResponsiveBreakpoints.of(context).isTablet) {
      return _buildDesktop();
    } else {
      return _buildMobile();
    }
  }

  Widget _buildDesktop() {
    return  MultiSplitView(
      controller: _controller,
      dividerBuilder: (
          Axis axis,
          int index,
          bool resizable,
          bool dragging,
          bool highlighted,
          MultiSplitViewThemeData themeData,
          ) {
        return DividerWidget(
          axis: Axis.vertical,
          index: index,
          themeData: MultiSplitViewThemeData(
            dividerThickness: themeData.dividerThickness,
            dividerPainter: DividerPainter(
              backgroundColor: Colors.grey.shade800,
              highlightedBackgroundColor: Colors.black,
              animationEnabled: false,
            ),
            dividerHandleBuffer: themeData.dividerHandleBuffer,
          ),
          highlighted: highlighted,
          resizable: resizable,
          dragging: false,
        );
      },
      builder: (context, area) {
        if (area.data == 1) {
          return TreeWidget();
        } else {
          return const NotesPanel();
        }
      },
    );
  }

  Widget _buildMobile() {
    return PageView(
        controller: _pageController,
        children: pageViewWidgets,
       );
  }
}
