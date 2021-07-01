// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Task _$TaskFromJson(Map<String, dynamic> json) {
  return Task()
    ..id = json['id'] as String?
    ..title = json['title'] as String?
    ..description = json['description'] as String?
    ..completedAt = json['completed_at'] == null
        ? null
        : json['completed_at'];
}

Map<String, dynamic> _$TaskToJson(Task instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'completed_at': instance.completedAt?.toString(),
    };
