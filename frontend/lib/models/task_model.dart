import 'dart:convert';

class TaskModel {
  final int id;
  final String name;
  final String state;
  final int time;
  final String url;
  final String output;
  final String file;

  TaskModel({
    this.id,
    this.name,
    this.state,
    this.time,
    this.url,
    this.output,
    this.file,
  });

  TaskModel copyWith({
    int id,
    String name,
    String state,
    int time,
    String url,
    String output,
    String file,
  }) {
    return TaskModel(
      id: id ?? this.id,
      name: name ?? this.name,
      state: state ?? this.state,
      time: time ?? this.time,
      url: url ?? this.url,
      output: output ?? this.output,
      file: file ?? this.file,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'state': state,
      'time': time,
      'url': url,
      'output': output,
      'file': file,
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'],
      name: map['name'],
      state: map['state'],
      time: map['time'],
      url: map['url'],
      output: map['output'].toString(),
      file: map['file'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TaskModel.fromJson(String source) => TaskModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TaskModel(id: $id, name: $name, state: $state, time: $time, url: $url, output: $output, file: $file)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is TaskModel &&
      other.id == id &&
      other.name == name &&
      other.state == state &&
      other.time == time &&
      other.url == url &&
      other.output == output &&
      other.file == file;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      state.hashCode ^
      time.hashCode ^
      url.hashCode ^
      output.hashCode ^
      file.hashCode;
  }
}
