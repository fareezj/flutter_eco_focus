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

_$SessionDistributionModelImpl _$$SessionDistributionModelImplFromJson(
        Map<String, dynamic> json) =>
    _$SessionDistributionModelImpl(
      categoryId: json['categoryId'] as String,
      name: json['name'] as String,
      percentage: json['percentage'] as String,
      totalHours: (json['totalHours'] as num).toDouble(),
    );

Map<String, dynamic> _$$SessionDistributionModelImplToJson(
        _$SessionDistributionModelImpl instance) =>
    <String, dynamic>{
      'categoryId': instance.categoryId,
      'name': instance.name,
      'percentage': instance.percentage,
      'totalHours': instance.totalHours,
    };
