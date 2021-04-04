import 'package:flutter/foundation.dart';
import 'package:frontend/config/locator.dart';
import 'package:frontend/models/api_response.dart';
import 'package:frontend/models/task_model.dart';
import 'package:frontend/repository/task_repository.dart';
import 'package:frontend/utils/app_logger.dart';
import 'package:frontend/utils/helper.dart';

class TaskProvider extends ChangeNotifier {
  final _repo = locator<TaskRepository>();

  List<TaskModel> _list = [];
  List<TaskModel> get list => [..._list];

  ViewState _state = ViewState.Idle;
  ViewState get state => _state;

  Future<void> getAllTasks() async {
    final ApiResponse res = await _repo.getAllTasks();

    if (res.code == 200) {
      _list = res.model;
      setState(ViewState.Done);
    } else {
      setState(ViewState.Error);
    }
  }

  Future<void> createNewTask(TaskModel task) async {
    final ApiResponse res = await _repo.scheduleTask(task);
    if (res.code == 201) {
      _list.insert(0, res.model);
      notifyListeners();
      Helper.showToast("Task scheduled successfully", true);
    } else {
      Helper.showToast("Something went worng", false);
    }
  }

  Future<void> updateTask(TaskModel task) async {
    final ApiResponse res = await _repo.modifyTask(task);
    if (res.code == 200) {
      final index = _list.indexWhere((element) => element.id == task.id);
      _list[index] = res.model;
      notifyListeners();
      Helper.showToast("Task scheduled successfully", true);
    } else {
      Helper.showToast("Something went worng", false);
    }
  }

  Future<void> canceltask(TaskModel task) async {
    final ApiResponse res = await _repo.cancelTask(task.id);
    if (res.code == 200) {
      final index = _list.indexWhere((element) => element.id == task.id);
      _list[index] = _list[index].copyWith(state: 'Cancelled');
      notifyListeners();
      Helper.showToast("Task cacncelled successfully", true);
    } else {
      Helper.showToast("Something went worng", false);
    }
  }

  Future<void> checkStatus(TaskModel task) async {
    final ApiResponse res = await _repo.checkStatus(task.id);
    if (res.code == 200) {
      final index = _list.indexWhere((element) => element.id == task.id);
      _list[index] = _list[index].copyWith(state: res.model);
      notifyListeners();
    } else {
      Helper.showToast("Something went worng", false);
    }
  }

  void setState(ViewState state) {
    _state = state;
    notifyListeners();
  }
}

enum ViewState { Idle, Loading, Done, Error }
