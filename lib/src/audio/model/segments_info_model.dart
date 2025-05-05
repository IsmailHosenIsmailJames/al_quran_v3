import 'dart:convert';

class SegmentsInfoModel {
  final int? surahNumber;
  final int? ayahNumber;
  final String? audioUrl;
  final int? duration;
  final List<List<int>>? segments;

  SegmentsInfoModel({
    this.surahNumber,
    this.ayahNumber,
    this.audioUrl,
    this.duration,
    this.segments,
  });

  SegmentsInfoModel copyWith({
    int? surahNumber,
    int? ayahNumber,
    String? audioUrl,
    int? duration,
    List<List<int>>? segments,
  }) => SegmentsInfoModel(
    surahNumber: surahNumber ?? this.surahNumber,
    ayahNumber: ayahNumber ?? this.ayahNumber,
    audioUrl: audioUrl ?? this.audioUrl,
    duration: duration ?? this.duration,
    segments: segments ?? this.segments,
  );

  factory SegmentsInfoModel.fromJson(String str) =>
      SegmentsInfoModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SegmentsInfoModel.fromMap(Map<String, dynamic> json) =>
      SegmentsInfoModel(
        surahNumber: json['surah_number'],
        ayahNumber: json['ayah_number'],
        audioUrl: json['audio_url'],
        duration: json['duration'],
        segments:
            json['segments'] == null
                ? []
                : List<List<int>>.from(
                  json['segments']!.map((x) => List<int>.from(x.map((x) => x))),
                ),
      );

  Map<String, dynamic> toMap() => {
    'surah_number': surahNumber,
    'ayah_number': ayahNumber,
    'audio_url': audioUrl,
    'duration': duration,
    'segments':
        segments == null
            ? []
            : List<dynamic>.from(
              segments!.map((x) => List<dynamic>.from(x.map((x) => x))),
            ),
  };
}
