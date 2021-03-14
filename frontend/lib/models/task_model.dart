import 'dart:convert';

import 'package:enum_to_string/enum_to_string.dart';

import 'package:frontend/models/status.dart';

class TaskModel {
  final int id;
  final String name;
  final Status status;
  final String taskUrl;
  final int delay;

  TaskModel({
    this.id,
    this.name,
    this.status,
    this.taskUrl,
    this.delay,
  });

  TaskModel copyWith({
    int id,
    String name,
    Status status,
    String taskUrl,
    int delay,
  }) {
    return TaskModel(
      id: id ?? this.id,
      name: name ?? this.name,
      status: status ?? this.status,
      taskUrl: taskUrl ?? this.taskUrl,
      delay: delay ?? this.delay,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'status': status.toString(),
      'taskUrl': taskUrl,
      'delay': delay,
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'],
      name: map['name'],
      status: EnumToString.fromString(Status.values, map['status']),
      taskUrl: map['taskUrl'],
      delay: map['delay'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TaskModel.fromJson(String source) => TaskModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TaskModel(id: $id, name: $name, status: $status, taskUrl: $taskUrl, delay: $delay)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is TaskModel &&
      other.id == id &&
      other.name == name &&
      other.status == status &&
      other.taskUrl == taskUrl &&
      other.delay == delay;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      status.hashCode ^
      taskUrl.hashCode ^
      delay.hashCode;
  }
}
