import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supa_manager/supa_manager.dart';

import '../models/models.dart';
import '../todos/todo_manager.dart';
import '../utils/utils.dart';
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
    return result.when(success: (data) {
      if (data is List<CurrentState>) {
        if (data.isNotEmpty) {
          return data[0].currentFiles;
        }
      }
      return null;
    }, failure: (Exception error) {
      logAndShowError(ref, error.toString());
      return null;
    }, errorMessage: (int code, String? message) {
      logAndShowError(ref, message!);
      return null;
    });
  }

  Future<CurrentState?> getCurrentState() async {
    final result = await databaseRepository.readEntries(currentStateTableData);
    return result.when(success: (data) {
      if (data is List<CurrentState>) {
        if (data.isNotEmpty) {
          return data[0];
        }
      }
      return null;
    }, failure: (Exception error) {
      logAndShowError(ref, error.toString());
      return null;
    }, errorMessage: (int code, String? message) {
      logAndShowError(ref, message!);
      return null;
    });
  }

  void updateCurrentFiles() async {
    final filesString = todoManager?.buildCurrentFilesString();
    if (filesString == null) {
      logAndShowError(ref, 'updateCurrentFiles: filesString is null');
      return;
    }
    final result = await databaseRepository.readEntries(currentStateTableData);
    await result.when(success: (data) async {
      if (data is List<CurrentState>) {
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
      }
    }, failure: (Exception error) {
      logAndShowError(ref, error.toString());
    }, errorMessage: (int code, String? message) {
      logAndShowError(ref, message!);
    });
  }
}
