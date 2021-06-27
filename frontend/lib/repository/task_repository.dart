import 'package:dio/dio.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:file_picker/file_picker.dart';
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
        (res.data as List).forEach((element) {
          list.add(TaskModel.fromMap(element));
        });

        return ApiResponse(model: list, code: 200);
      } else {
        return ApiResponse.withError("Something went wrong", res.statusCode);
      }
    } catch (e) {
      AppLogger.print(e);
      return ApiResponse.withError(e.toString(), 500);
    }
  }

  Future<ApiResponse<List<TaskModel>>> getTaskByFilter(String filter) async {
    try {
      final res = await _apiService.getClient().get('/tasks/filter/$filter');

      if (res.statusCode == 200) {
        List<TaskModel> list = [];
        (res.data as List).forEach((element) {
          list.add(TaskModel.fromMap(element));
        });

        return ApiResponse(model: list, code: 200);
      } else {
        return ApiResponse.withError("Something went wrong", res.statusCode);
      }
    } catch (e) {
      AppLogger.print(e);
      return ApiResponse.withError(e.toString(), 500);
    }
  }

  Future<ApiResponse<TaskModel>> scheduleTask(
      TaskModel task, PlatformFile file) async {
    try {
      final res = await _apiService.getClient().post(
            '/tasks',
            data: FormData.fromMap({
              "url": task.url,
              "time": task.time,
              "name": task.name,
              "type": file != null ? "FILE" : "URL",
              "file": MultipartFile.fromBytes(
                file.bytes,
                filename: file.name,
              ),
            }),
          );

      if (res.statusCode == 201) {
        final task = TaskModel.fromMap(res.data);
        return ApiResponse(model: task, code: 201);
      } else {
        AppLogger.print(res.data);
        return ApiResponse.withError("Something went wrong", res.statusCode);
      }
    } catch (e) {
      AppLogger.print(e);
      return ApiResponse.withError(e.toString(), 500);
    }
  }

  Future<ApiResponse<TaskModel>> modifyTask(
      TaskModel task, PlatformFile file) async {
    try {
      final res = await _apiService.getClient().patch(
        '/tasks/${task.id}',
        data: {
          "url": task.url,
          "time": task.time,
          "name": task.name,
        },
      );

      if (res.statusCode == 200) {
        final resTask = TaskModel.fromMap(res.data);
        return ApiResponse(model: resTask, code: 200);
      } else {
        AppLogger.print(res.data);
        return ApiResponse.withError("Something went wrong", res.statusCode);
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
        return ApiResponse.withError("Something went wrong", res.statusCode);
      }
    } catch (e) {
      AppLogger.print(e);
      return ApiResponse.withError(e.toString(), 500);
    }
  }

  Future<ApiResponse<bool>> cancelTask(int id) async {
    try {
      final res = await _apiService.getClient().patch('/tasks/cancel/$id');

      if (res.statusCode == 200) {
        return ApiResponse(model: true, code: 200);
      } else {
        return ApiResponse.withError("Something went wrong", res.statusCode);
      }
    } catch (e) {
      AppLogger.print(e);
      return ApiResponse.withError(e.toString(), 500);
    }
  }

  Future<ApiResponse<String>> checkStatus(int id) async {
    try {
      final res = await _apiService.getClient().get('/tasks/status/$id');

      if (res.statusCode == 200) {
        return ApiResponse(model: res.data['status'], code: 200);
      } else {
        return ApiResponse.withError("Something went wrong", res.statusCode);
      }
    } catch (e) {
      AppLogger.print(e);
      return ApiResponse.withError(e.toString(), 500);
    }
  }
}
