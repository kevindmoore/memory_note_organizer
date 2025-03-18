
import 'package:memory_notes_organizer/models/selection_state.dart';
import 'package:memory_notes_organizer/tree/tree_node.dart';

import 'node.dart';
import 'models.dart';

const int rootId = -1;

class UIState {
  bool changeTheme = false;
  bool showNewFolder = false;
  bool showDeleteMenu = false;
  bool loadingAllFiles = false;
  bool loadingFile = false;
  int editingRow = -1;
  SelectionState? selectionState;
  TodoFiles todoFiles = TodoFiles(<TodoFile>[]);
  Node rootNode =
      Node(name: 'root', id: rootId, type: NodeType.root, todoInfo: TodoInfo());
  Node? currentNode;
  Todo? currentlySelectedTodo;
  Category? currentlySelectedCategory;
  TodoFile? currentlySelectedTodoFile;
  int currentlySelectedIndex = -1;
  TreeNode? currentlySelectedNode;
  TreeNode? currentTreeRootNode = TreeNode(id: 'root');
}
