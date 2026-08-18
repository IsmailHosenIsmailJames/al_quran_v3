// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'setup_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SetupEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SetupEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SetupEvent()';
}


}

/// @nodoc
class $SetupEventCopyWith<$Res>  {
$SetupEventCopyWith(SetupEvent _, $Res Function(SetupEvent) __);
}


/// Adds pattern-matching-related methods to [SetupEvent].
extension SetupEventPatterns on SetupEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( SetupInitRequested value)?  initRequested,TResult Function( SetupLanguageChanged value)?  languageChanged,TResult Function( SetupTranslationSelected value)?  translationSelected,TResult Function( SetupTafsirSelected value)?  tafsirSelected,required TResult orElse(),}){
final _that = this;
switch (_that) {
case SetupInitRequested() when initRequested != null:
return initRequested(_that);case SetupLanguageChanged() when languageChanged != null:
return languageChanged(_that);case SetupTranslationSelected() when translationSelected != null:
return translationSelected(_that);case SetupTafsirSelected() when tafsirSelected != null:
return tafsirSelected(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( SetupInitRequested value)  initRequested,required TResult Function( SetupLanguageChanged value)  languageChanged,required TResult Function( SetupTranslationSelected value)  translationSelected,required TResult Function( SetupTafsirSelected value)  tafsirSelected,}){
final _that = this;
switch (_that) {
case SetupInitRequested():
return initRequested(_that);case SetupLanguageChanged():
return languageChanged(_that);case SetupTranslationSelected():
return translationSelected(_that);case SetupTafsirSelected():
return tafsirSelected(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( SetupInitRequested value)?  initRequested,TResult? Function( SetupLanguageChanged value)?  languageChanged,TResult? Function( SetupTranslationSelected value)?  translationSelected,TResult? Function( SetupTafsirSelected value)?  tafsirSelected,}){
final _that = this;
switch (_that) {
case SetupInitRequested() when initRequested != null:
return initRequested(_that);case SetupLanguageChanged() when languageChanged != null:
return languageChanged(_that);case SetupTranslationSelected() when translationSelected != null:
return translationSelected(_that);case SetupTafsirSelected() when tafsirSelected != null:
return tafsirSelected(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( MyAppLocalization currentLocalization)?  initRequested,TResult Function( MyAppLocalization localization)?  languageChanged,TResult Function( ResourceEntity translation)?  translationSelected,TResult Function( ResourceEntity tafsir)?  tafsirSelected,required TResult orElse(),}) {final _that = this;
switch (_that) {
case SetupInitRequested() when initRequested != null:
return initRequested(_that.currentLocalization);case SetupLanguageChanged() when languageChanged != null:
return languageChanged(_that.localization);case SetupTranslationSelected() when translationSelected != null:
return translationSelected(_that.translation);case SetupTafsirSelected() when tafsirSelected != null:
return tafsirSelected(_that.tafsir);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( MyAppLocalization currentLocalization)  initRequested,required TResult Function( MyAppLocalization localization)  languageChanged,required TResult Function( ResourceEntity translation)  translationSelected,required TResult Function( ResourceEntity tafsir)  tafsirSelected,}) {final _that = this;
switch (_that) {
case SetupInitRequested():
return initRequested(_that.currentLocalization);case SetupLanguageChanged():
return languageChanged(_that.localization);case SetupTranslationSelected():
return translationSelected(_that.translation);case SetupTafsirSelected():
return tafsirSelected(_that.tafsir);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( MyAppLocalization currentLocalization)?  initRequested,TResult? Function( MyAppLocalization localization)?  languageChanged,TResult? Function( ResourceEntity translation)?  translationSelected,TResult? Function( ResourceEntity tafsir)?  tafsirSelected,}) {final _that = this;
switch (_that) {
case SetupInitRequested() when initRequested != null:
return initRequested(_that.currentLocalization);case SetupLanguageChanged() when languageChanged != null:
return languageChanged(_that.localization);case SetupTranslationSelected() when translationSelected != null:
return translationSelected(_that.translation);case SetupTafsirSelected() when tafsirSelected != null:
return tafsirSelected(_that.tafsir);case _:
  return null;

}
}

}

/// @nodoc


class SetupInitRequested implements SetupEvent {
  const SetupInitRequested(this.currentLocalization);
  

 final  MyAppLocalization currentLocalization;

/// Create a copy of SetupEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SetupInitRequestedCopyWith<SetupInitRequested> get copyWith => _$SetupInitRequestedCopyWithImpl<SetupInitRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SetupInitRequested&&(identical(other.currentLocalization, currentLocalization) || other.currentLocalization == currentLocalization));
}


@override
int get hashCode => Object.hash(runtimeType,currentLocalization);

@override
String toString() {
  return 'SetupEvent.initRequested(currentLocalization: $currentLocalization)';
}


}

/// @nodoc
abstract mixin class $SetupInitRequestedCopyWith<$Res> implements $SetupEventCopyWith<$Res> {
  factory $SetupInitRequestedCopyWith(SetupInitRequested value, $Res Function(SetupInitRequested) _then) = _$SetupInitRequestedCopyWithImpl;
@useResult
$Res call({
 MyAppLocalization currentLocalization
});




}
/// @nodoc
class _$SetupInitRequestedCopyWithImpl<$Res>
    implements $SetupInitRequestedCopyWith<$Res> {
  _$SetupInitRequestedCopyWithImpl(this._self, this._then);

  final SetupInitRequested _self;
  final $Res Function(SetupInitRequested) _then;

/// Create a copy of SetupEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? currentLocalization = null,}) {
  return _then(SetupInitRequested(
null == currentLocalization ? _self.currentLocalization : currentLocalization // ignore: cast_nullable_to_non_nullable
as MyAppLocalization,
  ));
}


}

/// @nodoc


class SetupLanguageChanged implements SetupEvent {
  const SetupLanguageChanged(this.localization);
  

 final  MyAppLocalization localization;

/// Create a copy of SetupEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SetupLanguageChangedCopyWith<SetupLanguageChanged> get copyWith => _$SetupLanguageChangedCopyWithImpl<SetupLanguageChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SetupLanguageChanged&&(identical(other.localization, localization) || other.localization == localization));
}


@override
int get hashCode => Object.hash(runtimeType,localization);

@override
String toString() {
  return 'SetupEvent.languageChanged(localization: $localization)';
}


}

/// @nodoc
abstract mixin class $SetupLanguageChangedCopyWith<$Res> implements $SetupEventCopyWith<$Res> {
  factory $SetupLanguageChangedCopyWith(SetupLanguageChanged value, $Res Function(SetupLanguageChanged) _then) = _$SetupLanguageChangedCopyWithImpl;
@useResult
$Res call({
 MyAppLocalization localization
});




}
/// @nodoc
class _$SetupLanguageChangedCopyWithImpl<$Res>
    implements $SetupLanguageChangedCopyWith<$Res> {
  _$SetupLanguageChangedCopyWithImpl(this._self, this._then);

  final SetupLanguageChanged _self;
  final $Res Function(SetupLanguageChanged) _then;

/// Create a copy of SetupEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? localization = null,}) {
  return _then(SetupLanguageChanged(
null == localization ? _self.localization : localization // ignore: cast_nullable_to_non_nullable
as MyAppLocalization,
  ));
}


}

/// @nodoc


class SetupTranslationSelected implements SetupEvent {
  const SetupTranslationSelected(this.translation);
  

 final  ResourceEntity translation;

/// Create a copy of SetupEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SetupTranslationSelectedCopyWith<SetupTranslationSelected> get copyWith => _$SetupTranslationSelectedCopyWithImpl<SetupTranslationSelected>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SetupTranslationSelected&&(identical(other.translation, translation) || other.translation == translation));
}


@override
int get hashCode => Object.hash(runtimeType,translation);

@override
String toString() {
  return 'SetupEvent.translationSelected(translation: $translation)';
}


}

/// @nodoc
abstract mixin class $SetupTranslationSelectedCopyWith<$Res> implements $SetupEventCopyWith<$Res> {
  factory $SetupTranslationSelectedCopyWith(SetupTranslationSelected value, $Res Function(SetupTranslationSelected) _then) = _$SetupTranslationSelectedCopyWithImpl;
@useResult
$Res call({
 ResourceEntity translation
});


$ResourceEntityCopyWith<$Res> get translation;

}
/// @nodoc
class _$SetupTranslationSelectedCopyWithImpl<$Res>
    implements $SetupTranslationSelectedCopyWith<$Res> {
  _$SetupTranslationSelectedCopyWithImpl(this._self, this._then);

  final SetupTranslationSelected _self;
  final $Res Function(SetupTranslationSelected) _then;

/// Create a copy of SetupEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? translation = null,}) {
  return _then(SetupTranslationSelected(
null == translation ? _self.translation : translation // ignore: cast_nullable_to_non_nullable
as ResourceEntity,
  ));
}

/// Create a copy of SetupEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ResourceEntityCopyWith<$Res> get translation {
  
  return $ResourceEntityCopyWith<$Res>(_self.translation, (value) {
    return _then(_self.copyWith(translation: value));
  });
}
}

/// @nodoc


class SetupTafsirSelected implements SetupEvent {
  const SetupTafsirSelected(this.tafsir);
  

 final  ResourceEntity tafsir;

/// Create a copy of SetupEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SetupTafsirSelectedCopyWith<SetupTafsirSelected> get copyWith => _$SetupTafsirSelectedCopyWithImpl<SetupTafsirSelected>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SetupTafsirSelected&&(identical(other.tafsir, tafsir) || other.tafsir == tafsir));
}


@override
int get hashCode => Object.hash(runtimeType,tafsir);

@override
String toString() {
  return 'SetupEvent.tafsirSelected(tafsir: $tafsir)';
}


}

/// @nodoc
abstract mixin class $SetupTafsirSelectedCopyWith<$Res> implements $SetupEventCopyWith<$Res> {
  factory $SetupTafsirSelectedCopyWith(SetupTafsirSelected value, $Res Function(SetupTafsirSelected) _then) = _$SetupTafsirSelectedCopyWithImpl;
@useResult
$Res call({
 ResourceEntity tafsir
});


$ResourceEntityCopyWith<$Res> get tafsir;

}
/// @nodoc
class _$SetupTafsirSelectedCopyWithImpl<$Res>
    implements $SetupTafsirSelectedCopyWith<$Res> {
  _$SetupTafsirSelectedCopyWithImpl(this._self, this._then);

  final SetupTafsirSelected _self;
  final $Res Function(SetupTafsirSelected) _then;

/// Create a copy of SetupEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? tafsir = null,}) {
  return _then(SetupTafsirSelected(
null == tafsir ? _self.tafsir : tafsir // ignore: cast_nullable_to_non_nullable
as ResourceEntity,
  ));
}

/// Create a copy of SetupEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ResourceEntityCopyWith<$Res> get tafsir {
  
  return $ResourceEntityCopyWith<$Res>(_self.tafsir, (value) {
    return _then(_self.copyWith(tafsir: value));
  });
}
}

// dart format on
