// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mushaf_script_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MushafScriptPageModel {

@JsonKey(name: "page_number") int get pageNumber; List<MushafLine> get lines;
/// Create a copy of MushafScriptPageModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MushafScriptPageModelCopyWith<MushafScriptPageModel> get copyWith => _$MushafScriptPageModelCopyWithImpl<MushafScriptPageModel>(this as MushafScriptPageModel, _$identity);

  /// Serializes this MushafScriptPageModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MushafScriptPageModel&&(identical(other.pageNumber, pageNumber) || other.pageNumber == pageNumber)&&const DeepCollectionEquality().equals(other.lines, lines));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,pageNumber,const DeepCollectionEquality().hash(lines));

@override
String toString() {
  return 'MushafScriptPageModel(pageNumber: $pageNumber, lines: $lines)';
}


}

/// @nodoc
abstract mixin class $MushafScriptPageModelCopyWith<$Res>  {
  factory $MushafScriptPageModelCopyWith(MushafScriptPageModel value, $Res Function(MushafScriptPageModel) _then) = _$MushafScriptPageModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: "page_number") int pageNumber, List<MushafLine> lines
});




}
/// @nodoc
class _$MushafScriptPageModelCopyWithImpl<$Res>
    implements $MushafScriptPageModelCopyWith<$Res> {
  _$MushafScriptPageModelCopyWithImpl(this._self, this._then);

  final MushafScriptPageModel _self;
  final $Res Function(MushafScriptPageModel) _then;

/// Create a copy of MushafScriptPageModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? pageNumber = null,Object? lines = null,}) {
  return _then(MushafScriptPageModel(
pageNumber: null == pageNumber ? _self.pageNumber : pageNumber // ignore: cast_nullable_to_non_nullable
as int,lines: null == lines ? _self.lines : lines // ignore: cast_nullable_to_non_nullable
as List<MushafLine>,
  ));
}

}


/// Adds pattern-matching-related methods to [MushafScriptPageModel].
extension MushafScriptPageModelPatterns on MushafScriptPageModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MushafScriptPageModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MushafScriptPageModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MushafScriptPageModel value)  $default,){
final _that = this;
switch (_that) {
case _MushafScriptPageModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MushafScriptPageModel value)?  $default,){
final _that = this;
switch (_that) {
case _MushafScriptPageModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: "page_number")  int pageNumber,  List<MushafLine> lines)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MushafScriptPageModel() when $default != null:
return $default(_that.pageNumber,_that.lines);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: "page_number")  int pageNumber,  List<MushafLine> lines)  $default,) {final _that = this;
switch (_that) {
case _MushafScriptPageModel():
return $default(_that.pageNumber,_that.lines);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: "page_number")  int pageNumber,  List<MushafLine> lines)?  $default,) {final _that = this;
switch (_that) {
case _MushafScriptPageModel() when $default != null:
return $default(_that.pageNumber,_that.lines);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _MushafScriptPageModel extends MushafScriptPageModel {
  const _MushafScriptPageModel({@JsonKey(name: "page_number") required this.pageNumber, required  List<MushafLine> lines}): _lines = lines,super._();
  factory _MushafScriptPageModel.fromJson(Map<String, dynamic> json) => _$MushafScriptPageModelFromJson(json);

@override@JsonKey(name: "page_number") final  int pageNumber;
 final  List<MushafLine> _lines;
@override List<MushafLine> get lines {
  if (_lines is EqualUnmodifiableListView) return _lines;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_lines);
}


/// Create a copy of MushafScriptPageModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MushafScriptPageModelCopyWith<_MushafScriptPageModel> get copyWith => __$MushafScriptPageModelCopyWithImpl<_MushafScriptPageModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MushafScriptPageModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MushafScriptPageModel&&(identical(other.pageNumber, pageNumber) || other.pageNumber == pageNumber)&&const DeepCollectionEquality().equals(other._lines, _lines));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,pageNumber,const DeepCollectionEquality().hash(_lines));

@override
String toString() {
  return 'MushafScriptPageModel(pageNumber: $pageNumber, lines: $lines)';
}


}

/// @nodoc
abstract mixin class _$MushafScriptPageModelCopyWith<$Res> implements $MushafScriptPageModelCopyWith<$Res> {
  factory _$MushafScriptPageModelCopyWith(_MushafScriptPageModel value, $Res Function(_MushafScriptPageModel) _then) = __$MushafScriptPageModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: "page_number") int pageNumber, List<MushafLine> lines
});




}
/// @nodoc
class __$MushafScriptPageModelCopyWithImpl<$Res>
    implements _$MushafScriptPageModelCopyWith<$Res> {
  __$MushafScriptPageModelCopyWithImpl(this._self, this._then);

  final _MushafScriptPageModel _self;
  final $Res Function(_MushafScriptPageModel) _then;

/// Create a copy of MushafScriptPageModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? pageNumber = null,Object? lines = null,}) {
  return _then(_MushafScriptPageModel(
pageNumber: null == pageNumber ? _self.pageNumber : pageNumber // ignore: cast_nullable_to_non_nullable
as int,lines: null == lines ? _self._lines : lines // ignore: cast_nullable_to_non_nullable
as List<MushafLine>,
  ));
}


}


/// @nodoc
mixin _$MushafLine {

@JsonKey(name: "line_number") int get lineNumber;@JsonKey(name: "line_type") LineType get lineType;@JsonKey(name: "is_centered") bool get isCentered;@JsonKey(name: "surah_number") dynamic get surahNumber; String get content;@JsonKey(name: "first_word_id") int? get firstWordId;@JsonKey(name: "last_word_id") int? get lastWordId;
/// Create a copy of MushafLine
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MushafLineCopyWith<MushafLine> get copyWith => _$MushafLineCopyWithImpl<MushafLine>(this as MushafLine, _$identity);

  /// Serializes this MushafLine to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MushafLine&&(identical(other.lineNumber, lineNumber) || other.lineNumber == lineNumber)&&(identical(other.lineType, lineType) || other.lineType == lineType)&&(identical(other.isCentered, isCentered) || other.isCentered == isCentered)&&const DeepCollectionEquality().equals(other.surahNumber, surahNumber)&&(identical(other.content, content) || other.content == content)&&(identical(other.firstWordId, firstWordId) || other.firstWordId == firstWordId)&&(identical(other.lastWordId, lastWordId) || other.lastWordId == lastWordId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,lineNumber,lineType,isCentered,const DeepCollectionEquality().hash(surahNumber),content,firstWordId,lastWordId);

@override
String toString() {
  return 'MushafLine(lineNumber: $lineNumber, lineType: $lineType, isCentered: $isCentered, surahNumber: $surahNumber, content: $content, firstWordId: $firstWordId, lastWordId: $lastWordId)';
}


}

/// @nodoc
abstract mixin class $MushafLineCopyWith<$Res>  {
  factory $MushafLineCopyWith(MushafLine value, $Res Function(MushafLine) _then) = _$MushafLineCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: "line_number") int lineNumber,@JsonKey(name: "line_type") LineType lineType,@JsonKey(name: "is_centered") bool isCentered,@JsonKey(name: "surah_number") dynamic surahNumber, String content,@JsonKey(name: "first_word_id") int? firstWordId,@JsonKey(name: "last_word_id") int? lastWordId
});




}
/// @nodoc
class _$MushafLineCopyWithImpl<$Res>
    implements $MushafLineCopyWith<$Res> {
  _$MushafLineCopyWithImpl(this._self, this._then);

  final MushafLine _self;
  final $Res Function(MushafLine) _then;

/// Create a copy of MushafLine
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? lineNumber = null,Object? lineType = null,Object? isCentered = null,Object? surahNumber = freezed,Object? content = null,Object? firstWordId = freezed,Object? lastWordId = freezed,}) {
  return _then(MushafLine(
lineNumber: null == lineNumber ? _self.lineNumber : lineNumber // ignore: cast_nullable_to_non_nullable
as int,lineType: null == lineType ? _self.lineType : lineType // ignore: cast_nullable_to_non_nullable
as LineType,isCentered: null == isCentered ? _self.isCentered : isCentered // ignore: cast_nullable_to_non_nullable
as bool,surahNumber: freezed == surahNumber ? _self.surahNumber : surahNumber // ignore: cast_nullable_to_non_nullable
as dynamic,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,firstWordId: freezed == firstWordId ? _self.firstWordId : firstWordId // ignore: cast_nullable_to_non_nullable
as int?,lastWordId: freezed == lastWordId ? _self.lastWordId : lastWordId // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [MushafLine].
extension MushafLinePatterns on MushafLine {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MushafLine value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MushafLine() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MushafLine value)  $default,){
final _that = this;
switch (_that) {
case _MushafLine():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MushafLine value)?  $default,){
final _that = this;
switch (_that) {
case _MushafLine() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: "line_number")  int lineNumber, @JsonKey(name: "line_type")  LineType lineType, @JsonKey(name: "is_centered")  bool isCentered, @JsonKey(name: "surah_number")  dynamic surahNumber,  String content, @JsonKey(name: "first_word_id")  int? firstWordId, @JsonKey(name: "last_word_id")  int? lastWordId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MushafLine() when $default != null:
return $default(_that.lineNumber,_that.lineType,_that.isCentered,_that.surahNumber,_that.content,_that.firstWordId,_that.lastWordId);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: "line_number")  int lineNumber, @JsonKey(name: "line_type")  LineType lineType, @JsonKey(name: "is_centered")  bool isCentered, @JsonKey(name: "surah_number")  dynamic surahNumber,  String content, @JsonKey(name: "first_word_id")  int? firstWordId, @JsonKey(name: "last_word_id")  int? lastWordId)  $default,) {final _that = this;
switch (_that) {
case _MushafLine():
return $default(_that.lineNumber,_that.lineType,_that.isCentered,_that.surahNumber,_that.content,_that.firstWordId,_that.lastWordId);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: "line_number")  int lineNumber, @JsonKey(name: "line_type")  LineType lineType, @JsonKey(name: "is_centered")  bool isCentered, @JsonKey(name: "surah_number")  dynamic surahNumber,  String content, @JsonKey(name: "first_word_id")  int? firstWordId, @JsonKey(name: "last_word_id")  int? lastWordId)?  $default,) {final _that = this;
switch (_that) {
case _MushafLine() when $default != null:
return $default(_that.lineNumber,_that.lineType,_that.isCentered,_that.surahNumber,_that.content,_that.firstWordId,_that.lastWordId);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _MushafLine extends MushafLine {
  const _MushafLine({@JsonKey(name: "line_number") required this.lineNumber, @JsonKey(name: "line_type") required this.lineType, @JsonKey(name: "is_centered") required this.isCentered, @JsonKey(name: "surah_number") this.surahNumber, required this.content, @JsonKey(name: "first_word_id") this.firstWordId, @JsonKey(name: "last_word_id") this.lastWordId}): super._();
  factory _MushafLine.fromJson(Map<String, dynamic> json) => _$MushafLineFromJson(json);

@override@JsonKey(name: "line_number") final  int lineNumber;
@override@JsonKey(name: "line_type") final  LineType lineType;
@override@JsonKey(name: "is_centered") final  bool isCentered;
@override@JsonKey(name: "surah_number") final  dynamic surahNumber;
@override final  String content;
@override@JsonKey(name: "first_word_id") final  int? firstWordId;
@override@JsonKey(name: "last_word_id") final  int? lastWordId;

/// Create a copy of MushafLine
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MushafLineCopyWith<_MushafLine> get copyWith => __$MushafLineCopyWithImpl<_MushafLine>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MushafLineToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MushafLine&&(identical(other.lineNumber, lineNumber) || other.lineNumber == lineNumber)&&(identical(other.lineType, lineType) || other.lineType == lineType)&&(identical(other.isCentered, isCentered) || other.isCentered == isCentered)&&const DeepCollectionEquality().equals(other.surahNumber, surahNumber)&&(identical(other.content, content) || other.content == content)&&(identical(other.firstWordId, firstWordId) || other.firstWordId == firstWordId)&&(identical(other.lastWordId, lastWordId) || other.lastWordId == lastWordId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,lineNumber,lineType,isCentered,const DeepCollectionEquality().hash(surahNumber),content,firstWordId,lastWordId);

@override
String toString() {
  return 'MushafLine(lineNumber: $lineNumber, lineType: $lineType, isCentered: $isCentered, surahNumber: $surahNumber, content: $content, firstWordId: $firstWordId, lastWordId: $lastWordId)';
}


}

/// @nodoc
abstract mixin class _$MushafLineCopyWith<$Res> implements $MushafLineCopyWith<$Res> {
  factory _$MushafLineCopyWith(_MushafLine value, $Res Function(_MushafLine) _then) = __$MushafLineCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: "line_number") int lineNumber,@JsonKey(name: "line_type") LineType lineType,@JsonKey(name: "is_centered") bool isCentered,@JsonKey(name: "surah_number") dynamic surahNumber, String content,@JsonKey(name: "first_word_id") int? firstWordId,@JsonKey(name: "last_word_id") int? lastWordId
});




}
/// @nodoc
class __$MushafLineCopyWithImpl<$Res>
    implements _$MushafLineCopyWith<$Res> {
  __$MushafLineCopyWithImpl(this._self, this._then);

  final _MushafLine _self;
  final $Res Function(_MushafLine) _then;

/// Create a copy of MushafLine
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? lineNumber = null,Object? lineType = null,Object? isCentered = null,Object? surahNumber = freezed,Object? content = null,Object? firstWordId = freezed,Object? lastWordId = freezed,}) {
  return _then(_MushafLine(
lineNumber: null == lineNumber ? _self.lineNumber : lineNumber // ignore: cast_nullable_to_non_nullable
as int,lineType: null == lineType ? _self.lineType : lineType // ignore: cast_nullable_to_non_nullable
as LineType,isCentered: null == isCentered ? _self.isCentered : isCentered // ignore: cast_nullable_to_non_nullable
as bool,surahNumber: freezed == surahNumber ? _self.surahNumber : surahNumber // ignore: cast_nullable_to_non_nullable
as dynamic,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,firstWordId: freezed == firstWordId ? _self.firstWordId : firstWordId // ignore: cast_nullable_to_non_nullable
as int?,lastWordId: freezed == lastWordId ? _self.lastWordId : lastWordId // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
