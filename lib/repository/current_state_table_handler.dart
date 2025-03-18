import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lumberdash/lumberdash.dart';
import 'package:supa_manager/supa_manager.dart';

import '../models/models.dart';
import '../todos/todo_manager.dart';
import 'model_table_entries.dart';

class CurrentStateTableHandler {
  final Ref? ref;
  final SupaDatabaseManager databaseRepository;

  // final LocalRepo localRepo;
  final TodoManager? todoManager;

  final CurrentStateTableData currentStateTableData = CurrentStateTableData();

  CurrentStateTableHandler(
      this.ref, this.databaseRepository,
      // this.localRepo,
      this.todoManager);

  Future<String?> getCurrentFilesString() async {
    final result = await databaseRepository.readEntries(currentStateTableData);
    switch (result) {
      case Success(data: final data):
        if (data.isNotEmpty) {
          return data[0].currentFiles;
        }
        return null;
      case Failure(error: final error):
        logError( error.toString());
      case ErrorMessage(message: final message, code: _):
        logError( message!);
    }
    return null;
  }

  Future<CurrentState?> getCurrentState() async {
    final result = await databaseRepository.readEntries(currentStateTableData);
    switch (result) {
      case Success(data: final data):
        if (data.isNotEmpty) {
          return data[0];
        }
        return null;
      case Failure(error: final error):
        logError( error.toString());
      case ErrorMessage(message: final message, code: _):
        logError( message!);
    }
    return null;
  }

  void updateCurrentFiles() async {
    final filesString = todoManager?.buildCurrentFilesString();
    if (filesString == null) {
      logError( 'updateCurrentFiles: filesString is null');
      return;
    }
    final result = await databaseRepository.readEntries(currentStateTableData);
    switch (result) {
      case Success(data: final data):
        if (data.isNotEmpty) {
          final currentState = data[0];
          await databaseRepository.updateTableEntry(
              currentStateTableData,
              CurrentStateTableEntry(currentState.copyWith(
                  currentFiles: filesString, lastUpdated: DateTime.now())));
          // localRepo.updateCurrentState(currentState);
        } else {
          final currentState = CurrentState(currentFiles: filesString);
          await databaseRepository.addEntry(
              currentStateTableData, CurrentStateTableEntry(currentState));
          // localRepo.updateCurrentState(currentState);
        }
      case Failure(error: final error):
        logError( error.toString());
      case ErrorMessage(message: final message, code: _):
        logError( message!);
    }
  }
}
