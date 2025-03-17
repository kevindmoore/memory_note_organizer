


import '../models/models.dart';
import 'package:xml/xml.dart';

class TodoParser {
  TodoFile parseFile(String fileName, String contents) {
    final document = XmlDocument.parse(contents);
    final categories = <Category>[];
    final categoryElements = document.findAllElements('category');
    for (final categoryElement in categoryElements) {
      final category = parseCategory(categoryElement);
      categories.add(category);
    }
    return TodoFile(name: fileName, categories: categories,lastUpdated: DateTime.now());
  }

  Category parseCategory(XmlElement categoryElement) {
    final todos = <Todo>[];
    final todoElements = categoryElement.findElements('todo');
    var orderCount = 0;
    for (final todoElement in todoElements) {
      final todo = parseTodo(todoElement, orderCount);
      orderCount++;
      todos.add(todo);
    }
    final category = Category(
        name: Uri.decodeQueryComponent(categoryElement.getAttribute('name')!),
        todos: todos,
        lastUpdated: DateTime.now());

    return category;
  }

  Todo parseTodo(XmlElement todoElement, int orderCount) {
    final name = Uri.decodeQueryComponent(todoElement.getAttribute('name')!);
/*
    final startdate = parseDateElement(todoElement, 'startdate');
    final endDate = parseDateElement(todoElement, 'enddate');
    final dateFinished = parseDateElement(todoElement, 'dateFinished');
    var status = STATUS.NOT_STARTED;
    final statusInt = todoElement.getAttribute('status');
    if (statusInt != null) {
      status = STATUS.values[int.parse(statusInt)];
    }
    var priority = PRIORITY.LOW;
    final priorityInt = todoElement.getAttribute('priority');
    if (priorityInt != null) {
      priority = PRIORITY.values[int.parse(priorityInt)];
    }
*/
    var done = false;
    final doneString = todoElement.getAttribute('done');
    if (doneString != null) {
      done = doneString == 'true';
    }
    var visible = true;
    final visibleString = todoElement.getAttribute('visible');
    if (visibleString != null) {
      visible = visibleString == 'true';
    }
    var expanded = false;
    final expandedString = todoElement.getAttribute('expanded');
    if (expandedString != null) {
      expanded = expandedString == 'true';
    }

    var notes = '';
    final notesString = todoElement.getAttribute('notes');
    if (notesString != null) {
      notes = Uri.decodeQueryComponent(notesString);
      // var notes1 = notes.replaceAll('\n', ' ');
      final notes1 = notes.replaceAll(
          RegExp(r'\{\\[^}]*\}', multiLine: true, dotAll: true), '');
      final notes2 = notes1.replaceAll(
          RegExp(r'\\[^\\ \n]{2,4}', multiLine: true, dotAll: true), '');
      final notes3 = notes2.replaceAll('+', ' ');
      final lastIndex = notes3.lastIndexOf('}');
      if (lastIndex != -1) {
        notes = notes3.substring(0, lastIndex);
      } else {
        notes = notes3;
      }
      // logMessage(notes3);
    }
    final children = parseTodoChildren(todoElement);

    final todo = Todo(
        name: name,
        // startDate: startdate,
        // endDate: endDate,
        // dateFinished: dateFinished,
        // status: status,
        // priority: priority,
        done: done,
        order: orderCount,
        visible: visible,
        expanded: expanded,
        children: children,
        notes: notes,
        lastUpdated: DateTime.now());

    return todo;
  }

  List<Todo> parseTodoChildren(XmlElement todoElement) {
    final children = <Todo>[];
    final todoElements = todoElement.findElements('todo');
    var orderCount = 0;
    for (final childTodoElement in todoElements) {
      final childTodo = parseTodo(childTodoElement, orderCount);
      orderCount++;
      children.add(childTodo);
    }
    return children;
  }

  DateTime? parseDateElement(XmlElement dateElement, String elementName) {
    final dateString = dateElement.getAttribute(elementName);
    if (dateString == null) {
      return null;
    }
    return DateTime(parseDate(dateString, 4, 4), parseDate(dateString, 0, 2),
        parseDate(dateString, 2, 2));
  }

  int parseDate(String dateString, int position, int size) {
    return int.parse(dateString.substring(position, position + size - 1));
  }
}
