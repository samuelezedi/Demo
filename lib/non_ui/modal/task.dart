import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'task.g.dart';

@JsonSerializable(explicitToJson: true)
class Task {
  Task();

  String? id;
  String? title;
  String? description;
  @JsonKey(name: 'completed_at')
  Timestamp? completedAt;

  bool get isNew {
    return id==null;
  }

  bool get isCompleted {
    return completedAt!=null;
  }

  void toggleComplete() {
    if (isCompleted) {
      completedAt = null;
    } else {
      completedAt = Timestamp.now();
    }
  }

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

  Map<String, dynamic> toJson() => _$TaskToJson(this);
}
