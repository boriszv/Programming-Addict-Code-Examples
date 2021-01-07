// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resource_error.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResourceError _$ResourceErrorFromJson(Map<String, dynamic> json) {
  return ResourceError(
    json['type'] as String,
    json['message'] as String,
  );
}

Map<String, dynamic> _$ResourceErrorToJson(ResourceError instance) =>
    <String, dynamic>{
      'type': instance.type,
      'message': instance.message,
    };
