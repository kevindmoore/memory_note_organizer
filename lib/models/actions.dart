import 'dart:core';

class ActionLog {
  DateTime date;
  DateTime time;
  String phone;
  List<String> persons = <String>[];
  String currentPerson;
  String action;

  ActionLog(this.date, this.time, this.phone, this.persons, this.currentPerson,
      this.action);
}

class Action {
  List<String> persons = <String>[];
  String currentPerson;
  List<ActionLog> actionLogs = <ActionLog>[];

  Action(
      {required this.persons,
      required this.currentPerson,
      required this.actionLogs});
}
