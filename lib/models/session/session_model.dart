import 'package:freezed_annotation/freezed_annotation.dart';

part 'session_model.freezed.dart';
part 'session_model.g.dart';

@freezed
class SessionModel with _$SessionModel {
  const factory SessionModel({
    required String id,
    required String name,
    required String categoryId,
    required String targetTime,
    required String focusedTime,
    required String createdTime,
    required String createdDate,
    required String treeGrowthLevel,
  }) = _SessionModel;

  factory SessionModel.fromJson(Map<String, Object?> json) =>
      _$SessionModelFromJson(json);
}
