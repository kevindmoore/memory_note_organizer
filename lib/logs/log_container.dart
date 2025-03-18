

class LogContainer {
  List<String> logEntries = <String>[];

  void addLog(String log) {
    logEntries.add(log);
  }

  void clearLogs() {
    logEntries.clear();
  }
}