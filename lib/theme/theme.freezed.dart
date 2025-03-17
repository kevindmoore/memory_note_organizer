// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'theme.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ThemeColors {
  Color get startGradientColor => throw _privateConstructorUsedError;
  Color get endGradientColor => throw _privateConstructorUsedError;
  Color get textColor => throw _privateConstructorUsedError;
  Color get inverseTextColor => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ThemeColorsCopyWith<ThemeColors> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ThemeColorsCopyWith<$Res> {
  factory $ThemeColorsCopyWith(
          ThemeColors value, $Res Function(ThemeColors) then) =
      _$ThemeColorsCopyWithImpl<$Res, ThemeColors>;
  @useResult
  $Res call(
      {Color startGradientColor,
      Color endGradientColor,
      Color textColor,
      Color inverseTextColor});
}

/// @nodoc
class _$ThemeColorsCopyWithImpl<$Res, $Val extends ThemeColors>
    implements $ThemeColorsCopyWith<$Res> {
  _$ThemeColorsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? startGradientColor = null,
    Object? endGradientColor = null,
    Object? textColor = null,
    Object? inverseTextColor = null,
  }) {
    return _then(_value.copyWith(
      startGradientColor: null == startGradientColor
          ? _value.startGradientColor
          : startGradientColor // ignore: cast_nullable_to_non_nullable
              as Color,
      endGradientColor: null == endGradientColor
          ? _value.endGradientColor
          : endGradientColor // ignore: cast_nullable_to_non_nullable
              as Color,
      textColor: null == textColor
          ? _value.textColor
          : textColor // ignore: cast_nullable_to_non_nullable
              as Color,
      inverseTextColor: null == inverseTextColor
          ? _value.inverseTextColor
          : inverseTextColor // ignore: cast_nullable_to_non_nullable
              as Color,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ThemeColorsImplCopyWith<$Res>
    implements $ThemeColorsCopyWith<$Res> {
  factory _$$ThemeColorsImplCopyWith(
          _$ThemeColorsImpl value, $Res Function(_$ThemeColorsImpl) then) =
      __$$ThemeColorsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Color startGradientColor,
      Color endGradientColor,
      Color textColor,
      Color inverseTextColor});
}

/// @nodoc
class __$$ThemeColorsImplCopyWithImpl<$Res>
    extends _$ThemeColorsCopyWithImpl<$Res, _$ThemeColorsImpl>
    implements _$$ThemeColorsImplCopyWith<$Res> {
  __$$ThemeColorsImplCopyWithImpl(
      _$ThemeColorsImpl _value, $Res Function(_$ThemeColorsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? startGradientColor = null,
    Object? endGradientColor = null,
    Object? textColor = null,
    Object? inverseTextColor = null,
  }) {
    return _then(_$ThemeColorsImpl(
      startGradientColor: null == startGradientColor
          ? _value.startGradientColor
          : startGradientColor // ignore: cast_nullable_to_non_nullable
              as Color,
      endGradientColor: null == endGradientColor
          ? _value.endGradientColor
          : endGradientColor // ignore: cast_nullable_to_non_nullable
              as Color,
      textColor: null == textColor
          ? _value.textColor
          : textColor // ignore: cast_nullable_to_non_nullable
              as Color,
      inverseTextColor: null == inverseTextColor
          ? _value.inverseTextColor
          : inverseTextColor // ignore: cast_nullable_to_non_nullable
              as Color,
    ));
  }
}

/// @nodoc

class _$ThemeColorsImpl implements _ThemeColors {
  const _$ThemeColorsImpl(
      {required this.startGradientColor,
      required this.endGradientColor,
      required this.textColor,
      required this.inverseTextColor});

  @override
  final Color startGradientColor;
  @override
  final Color endGradientColor;
  @override
  final Color textColor;
  @override
  final Color inverseTextColor;

  @override
  String toString() {
    return 'ThemeColors(startGradientColor: $startGradientColor, endGradientColor: $endGradientColor, textColor: $textColor, inverseTextColor: $inverseTextColor)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ThemeColorsImpl &&
            (identical(other.startGradientColor, startGradientColor) ||
                other.startGradientColor == startGradientColor) &&
            (identical(other.endGradientColor, endGradientColor) ||
                other.endGradientColor == endGradientColor) &&
            (identical(other.textColor, textColor) ||
                other.textColor == textColor) &&
            (identical(other.inverseTextColor, inverseTextColor) ||
                other.inverseTextColor == inverseTextColor));
  }

  @override
  int get hashCode => Object.hash(runtimeType, startGradientColor,
      endGradientColor, textColor, inverseTextColor);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ThemeColorsImplCopyWith<_$ThemeColorsImpl> get copyWith =>
      __$$ThemeColorsImplCopyWithImpl<_$ThemeColorsImpl>(this, _$identity);
}

abstract class _ThemeColors implements ThemeColors {
  const factory _ThemeColors(
      {required final Color startGradientColor,
      required final Color endGradientColor,
      required final Color textColor,
      required final Color inverseTextColor}) = _$ThemeColorsImpl;

  @override
  Color get startGradientColor;
  @override
  Color get endGradientColor;
  @override
  Color get textColor;
  @override
  Color get inverseTextColor;
  @override
  @JsonKey(ignore: true)
  _$$ThemeColorsImplCopyWith<_$ThemeColorsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
