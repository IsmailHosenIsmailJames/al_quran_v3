// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'surah_search_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SurahSearchState _$SurahSearchStateFromJson(Map<String, dynamic> json) =>
    _SurahSearchState(
      query: json['query'] as String? ?? "",
      filteredSurahs:
          (json['filteredSurahs'] as List<dynamic>?)
              ?.map((e) => SurahInfoModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$SurahSearchStateToJson(_SurahSearchState instance) =>
    <String, dynamic>{
      'query': instance.query,
      'filteredSurahs': instance.filteredSurahs.map((e) => e.toJson()).toList(),
    };
