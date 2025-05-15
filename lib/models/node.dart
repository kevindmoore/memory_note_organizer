import 'dart:core';

import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:lumberdash/lumberdash.dart';
import 'package:memory_notes_organizer/tree/tree_node.dart';

/// KEEP THIS AWAY from Freezed

enum NodeType { root, file, category, todo }

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

// ignore: must_be_immutable
class Node extends Equatable {
  final String name;
  final int? id;
  final List<Node> children = [];
  final Node? previous;
  final NodeType type;
  TodoInfo todoInfo;

  Node({required this.name, this.id, required this.type, this.previous, required this.todoInfo});

  // @override
  // String toString() {
  //   return 'Node(name: $name, id: $id, type: $type, previous: $previous todoInfo: $todoInfo children: ${children.length})';
  // }
  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [id, name, previous, type, todoInfo];

  // @override
  // bool operator ==(Object other) {
  //   return identical(this, other) ||
  //       other is Node &&
  //           runtimeType == other.runtimeType &&
  //           name == other.name &&
  //           id == other.id &&
  //           type == other.type; // Use a helper
  // }
  //
  // @override
  // int get hashCode => Object.hash(runtimeType, name, id, type);

  int? getId() {
    return id;
  }

  Node copyWithName(String newName) {
    return Node(name: newName, id: id, type: type, previous: previous, todoInfo: todoInfo);
  }

  int numChildren() => children.length;

  void clearChildren() {
    children.clear();
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
    children.addAll(children);
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

  Node? findParentTodoNode(Node rootNode, int? id) {
    final todoNode = findTodoNode(rootNode, id);
    if (todoNode != null) {
      if (todoNode.todoInfo.parentId != null) {
        return findTodoNode(rootNode, todoNode.todoInfo.parentId);
      } else {
        return findCategoryNode(rootNode, todoNode.todoInfo.categoryId);
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

  Node? findNodeById(Node rootNode, int? id) {
    if (id == null) {
      return null;
    }
    for (final fileNode in rootNode.children) {
      if (fileNode.id == id) {
        return fileNode;
      }
      for (final categoryNode in fileNode.children) {
        if (categoryNode.id == id) {
          return categoryNode;
        }
        final foundTodoNode = recursiveIdSearch(categoryNode, id);
        if (foundTodoNode != null) {
          return foundTodoNode;
        }
      }
    }
    return null;
  }

  int findNodeIndex(Node rootNode, int? id) {
    if (id == null) {
      return -1;
    }
    int count = -1; // Start at -1 to account for root
    final foundNode = findNodeById(rootNode, id);
    if (foundNode == null) {
      return -1;
    }
    Node? currentParentNode = foundNode.previous;
    Node? currentNode = foundNode;
    if (currentParentNode == null) {
      final index = rootNode.children.indexWhere(
            (node) => node.id == currentNode!.id!,
      );
      return index;
    }
    while (currentParentNode != null && currentParentNode != rootNode) {
      switch (currentParentNode.type) {
        case NodeType.root:
        case NodeType.file:
          final index = currentParentNode.children.indexWhere(
            (node) => node.id == currentNode!.id!,
          );
          logMessage('Found file index of $index for node: ${currentNode?.name}');
          if (index != -1) {
            count += index + 1;
          }
          break;
        case NodeType.category:
          final index = currentParentNode.children.indexWhere(
            (node) => node.id == currentNode!.id!,
          );
          logMessage('Found category index of $index for node: ${currentNode?.name}');
          if (index != -1) {
            count += index + 1;
          }
          break;
        case NodeType.todo:
          final index = currentParentNode.children.indexWhere(
            (node) => node.id == currentNode!.id!,
          );
          logMessage('Found todo index of $index for node: ${currentNode?.name}');
          if (index != -1) {
            count += index + 1;
          }
          break;
      }
      currentNode = currentParentNode;
      currentParentNode = currentParentNode.previous;
    }
    logMessage('Count $count for node: ${currentNode?.name}');
    return count;
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
          fileNode.children.remove(categoryNode);
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

  void replaceChildNode(Node categoryNode, Node newTodoNode) {
    final index = categoryNode.indexOfNode(categoryNode, newTodoNode);
    if (index != -1) {
      categoryNode.children[index] = newTodoNode;
    }
  }

  void replaceChildNodeWithNode(Node parentNode, Node currentNode, Node newTodoNode) {
    var index = 0;
    for (final treeNode in parentNode.children) {
      if (identical(treeNode, currentNode)) {
        parentNode.children[index] = newTodoNode;
      }
      index++;
    }
  }

  void deleteNode(Node currentlySelectedNode) {
    Node? parentNode = currentlySelectedNode.previous;
    if (parentNode != null) {
      parentNode.children.remove(currentlySelectedNode);
    }
  }
}
