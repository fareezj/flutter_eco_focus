// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SessionModelImpl _$$SessionModelImplFromJson(Map<String, dynamic> json) =>
    _$SessionModelImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      categoryId: json['categoryId'] as String,
      targetTime: json['targetTime'] as String,
      focusedTime: json['focusedTime'] as String,
      createdTime: json['createdTime'] as String,
      createdDate: json['createdDate'] as String,
      treeGrowthLevel: json['treeGrowthLevel'] as String,
    );

Map<String, dynamic> _$$SessionModelImplToJson(_$SessionModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'categoryId': instance.categoryId,
      'targetTime': instance.targetTime,
      'focusedTime': instance.focusedTime,
      'createdTime': instance.createdTime,
      'createdDate': instance.createdDate,
      'treeGrowthLevel': instance.treeGrowthLevel,
    };