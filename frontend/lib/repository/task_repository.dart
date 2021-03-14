import 'package:enum_to_string/enum_to_string.dart';
import 'package:frontend/config/locator.dart';
import 'package:frontend/models/api_response.dart';
import 'package:frontend/models/status.dart';
import 'package:frontend/models/task_model.dart';
import 'package:frontend/services/api_service.dart';
import 'package:frontend/utils/app_logger.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class TaskRepository {
  final ApiService _apiService = locator<ApiService>();

  Future<ApiResponse<List<TaskModel>>> getAllTasks() async {
    try {
      final res = await _apiService.getClient().get('/tasks');

      if (res.statusCode == 200) {
        List<TaskModel> list = [];
        (res.data['data'] as List).forEach((element) {
          list.add(TaskModel.fromMap(element));
        });

        return ApiResponse(model: list, code: 200);
      } else {
        return ApiResponse.withError(res.data['message'], 500);
      }
    } catch (e) {
      AppLogger.print(e);
      return ApiResponse.withError(e.toString(), 500);
    }
  }

  Future<ApiResponse<TaskModel>> scheduleTask(TaskModel taskModel) async {
    try {
      final res = await _apiService.getClient().post('/tasks', data: taskModel);

      if (res.statusCode == 200) {
        final task = TaskModel.fromMap(res.data['data']);
        return ApiResponse(model: task, code: 200);
      } else {
        return ApiResponse.withError(res.data['message'], 500);
      }
    } catch (e) {
      AppLogger.print(e);
      return ApiResponse.withError(e.toString(), 500);
    }
  }

  Future<ApiResponse<TaskModel>> modifyTask(TaskModel task) async {
    try {
      final res = await _apiService.getClient().patch('/tasks', data: task);

      if (res.statusCode == 200) {
        final resTask = TaskModel.fromMap(res.data['data']);
        return ApiResponse(model: resTask, code: 200);
      } else {
        return ApiResponse.withError(res.data['message'], 500);
      }
    } catch (e) {
      AppLogger.print(e);
      return ApiResponse.withError(e.toString(), 500);
    }
  }

  Future<ApiResponse<Status>> getTaskStatus(int id) async {
    try {
      final res = await _apiService.getClient().get('/tasks/status/$id');

      if (res.statusCode == 200) {
        final status = res.data['data'];
        return ApiResponse(
          model: EnumToString.fromString(Status.values, status),
          code: 200,
        );
      } else {
        return ApiResponse.withError(res.data['message'], 500);
      }
    } catch (e) {
      AppLogger.print(e);
      return ApiResponse.withError(e.toString(), 500);
    }
  }

  Future<ApiResponse<TaskModel>> cancelTask(int id) async {
    try {
      final res = await _apiService.getClient().patch('/tasks/status/$id');

      if (res.statusCode == 200) {
        final resTask = TaskModel.fromMap(res.data['data']);
        return ApiResponse(model: resTask, code: 200);
      } else {
        return ApiResponse.withError(res.data['message'], 500);
      }
    } catch (e) {
      AppLogger.print(e);
      return ApiResponse.withError(e.toString(), 500);
    }
  }
}
