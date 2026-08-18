// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'download_progress.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DownloadProgress _$DownloadProgressFromJson(Map<String, dynamic> json) =>
    _DownloadProgress(
      stepName: json['stepName'] as String,
      percentage: (json['percentage'] as num?)?.toDouble(),
      currentStepIndex: (json['currentStepIndex'] as num?)?.toInt() ?? 0,
      totalSteps: (json['totalSteps'] as num?)?.toInt() ?? 5,
      status: $enumDecode(_$DownloadStepStatusEnumMap, json['status']),
      errorMessage: json['errorMessage'] as String?,
    );

Map<String, dynamic> _$DownloadProgressToJson(_DownloadProgress instance) =>
    <String, dynamic>{
      'stepName': instance.stepName,
      'percentage': instance.percentage,
      'currentStepIndex': instance.currentStepIndex,
      'totalSteps': instance.totalSteps,
      'status': _$DownloadStepStatusEnumMap[instance.status]!,
      'errorMessage': instance.errorMessage,
    };

const _$DownloadStepStatusEnumMap = {
  DownloadStepStatus.initial: 'initial',
  DownloadStepStatus.inProgress: 'inProgress',
  DownloadStepStatus.completed: 'completed',
  DownloadStepStatus.failed: 'failed',
};
