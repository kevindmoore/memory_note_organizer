import 'package:collection/collection.dart';

import '../ui/tree/tree_node.dart'; // <- required or firstWhereOrNull is not defined

enum NodeType { root, file, category, todo }

class Node {
  final String name;
  final int? id;
  final List<Node> children = [];
  final Node? previous;
  final NodeType type;
  TodoInfo todoInfo;

  Node(
      {required this.name,
      this.id,
      required this.type,
      this.previous,
      required this.todoInfo});

  @override
  String toString() {
    return 'Node(name: $name, id: $id, type: $type, previous: $previous todoInfo: $todoInfo children: ${children.length})';
  }

  int? getId() {
    return id;
  }

  int numChildren() => children.length;

  void clearChildren() {
    children.clear();
  }

  Node copyWith(
      {String? newName, int? newId, Node? newPrevious, Node? newNext}) {
    final updatedName = newName ?? name;
    final updatedId = newId ?? id;
    final updatedPrevious = newPrevious ?? previous;
    return Node(
      name: updatedName,
      id: updatedId,
      type: type,
      todoInfo: todoInfo,
      previous: updatedPrevious,
    );
  }

  Node? findTodoFileNode(Node rootNode, int? id) {
    if (id == null) {
      return null;
    }
    return rootNode.children.firstWhereOrNull((node) => node.id == id);
  }

  void addChildNode(Node childNode) {
    children.add(childNode);
  }

  void addChildren(List<Node> children) {
    for (final node in children) {
      addChildNode(node);
    }
  }

  Node? findCategoryNode(Node rootNode, int? id) {
    if (id == null) {
      return null;
    }
    for (final fileNode in rootNode.children) {
      for (final categoryNode in fileNode.children) {
        if (categoryNode.id == id) {
          return categoryNode;
        }
      }
    }
    return null;
  }

  Node? findTodoNode(Node rootNode, int? id) {
    if (id == null) {
      return null;
    }
    for (final fileNode in rootNode.children) {
      for (final categoryNode in fileNode.children) {
        final foundTodoNode = recursiveIdSearch(categoryNode, id);
        if (foundTodoNode != null) {
          return foundTodoNode;
        }
      }
    }
    return null;
  }

  int findTodoNodeIndex(Node rootNode, int? id) {
    if (id == null) {
      return -1;
    }
    for (final fileNode in rootNode.children) {
      for (final categoryNode in fileNode.children) {
        final foundTodoIndex = recursiveIndexSearch(categoryNode, id);
        if (foundTodoIndex != null) {
          return foundTodoIndex;
        }
      }
    }
    return -1;
  }

  int? recursiveIndexSearch(Node node, int? id) {
    if (id == null) {
      return null;
    }
    var count = 0;
    for (final childNode in node.children) {
      if (childNode.id == id) {
        return count;
      }
      final subChildIndex = recursiveIndexSearch(childNode, id);
      if (subChildIndex != null) {
        return subChildIndex;
      }
      count++;
    }
    return null;
  }

  Node? recursiveIdSearch(Node node, int? id) {
    if (id == null) {
      return null;
    }
    for (final childNode in node.children) {
      if (childNode.id == id) {
        return childNode;
      }
      final subChildSearch = recursiveIdSearch(childNode, id);
      if (subChildSearch != null) {
        return subChildSearch;
      }
    }
    return null;
  }

  void removeNode(Node rootNode, int id) {
    for (final fileNode in rootNode.children) {
      if (fileNode.id == id) {
        rootNode.children.remove(fileNode);
        return;
      }
      for (final categoryNode in fileNode.children) {
        if (categoryNode.id == id) {
          fileNode.children.remove(fileNode);
          return;
        }
        final foundTodo = recursiveTodoDelete(categoryNode, id);
        if (foundTodo != null) {
          return;
        }
      }
    }
  }

  Node? recursiveTodoDelete(Node node, int id) {
    for (final childNode in node.children) {
      if (childNode.id == id) {
        node.children.remove(childNode);
        return childNode;
      }
      final foundInChildren = recursiveTodoDelete(childNode, id);
      if (foundInChildren != null) {
        return foundInChildren;
      }
    }
    return null;
  }
}

class TodoInfo {
  int? todoFileId;
  int? categoryId;
  int? parentId;

  TodoInfo({this.todoFileId, this.categoryId, this.parentId});

  @override
  String toString() {
    return 'TodoInfo(todoFileId: $todoFileId, categoryId: $categoryId, parentId: $parentId)';
  }
}

TreeNode? findTreeNode(TreeNode parent, Node child) {
  final childId = child.id.toString();
  for (final treeNode in parent.children) {
    if (treeNode.id == childId) {
      return treeNode;
    }
    if (treeNode.hasChildren) {
      final foundChildNode = findTreeNode(treeNode, child);
      if (foundChildNode != null) {
        return foundChildNode;
      }
    }
  }
  return null;
}

int indexOfTreeNode(TreeNode parent, Node child) {
  var index = 0;
  final childId = child.id.toString();
  for (final treeNode in parent.children) {
    if (treeNode.id == childId) {
      return index;
    }
    index++;
    if (treeNode.hasChildren) {
      final foundIndex = indexOfTreeNode(treeNode, child);
      if (foundIndex != -1) {
        return foundIndex;
      }
    }
  }
  return -1;
}

int indexOfNode(Node parent, Node child) {
  var index = 0;
  final childId = child.id;
  for (final treeNode in parent.children) {
    if (treeNode.id == childId) {
      return index;
    }
    index++;
    if (treeNode.children.isNotEmpty) {
      final foundIndex = indexOfNode(treeNode, child);
      if (foundIndex != -1) {
        return foundIndex;
      }
    }
  }
  return -1;
}