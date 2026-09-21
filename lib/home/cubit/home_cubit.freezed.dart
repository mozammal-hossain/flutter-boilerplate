// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$HomeState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HomeState()';
}


}

/// @nodoc
class $HomeStateCopyWith<$Res>  {
$HomeStateCopyWith(HomeState _, $Res Function(HomeState) __);
}


/// Adds pattern-matching-related methods to [HomeState].
extension HomeStatePatterns on HomeState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( HomeInitial value)?  initial,TResult Function( HomeLoading value)?  loading,TResult Function( HomeLoaded value)?  loaded,TResult Function( HomeDetailLoading value)?  detailLoading,TResult Function( HomeDetailLoaded value)?  detailLoaded,TResult Function( HomeError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case HomeInitial() when initial != null:
return initial(_that);case HomeLoading() when loading != null:
return loading(_that);case HomeLoaded() when loaded != null:
return loaded(_that);case HomeDetailLoading() when detailLoading != null:
return detailLoading(_that);case HomeDetailLoaded() when detailLoaded != null:
return detailLoaded(_that);case HomeError() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( HomeInitial value)  initial,required TResult Function( HomeLoading value)  loading,required TResult Function( HomeLoaded value)  loaded,required TResult Function( HomeDetailLoading value)  detailLoading,required TResult Function( HomeDetailLoaded value)  detailLoaded,required TResult Function( HomeError value)  error,}){
final _that = this;
switch (_that) {
case HomeInitial():
return initial(_that);case HomeLoading():
return loading(_that);case HomeLoaded():
return loaded(_that);case HomeDetailLoading():
return detailLoading(_that);case HomeDetailLoaded():
return detailLoaded(_that);case HomeError():
return error(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( HomeInitial value)?  initial,TResult? Function( HomeLoading value)?  loading,TResult? Function( HomeLoaded value)?  loaded,TResult? Function( HomeDetailLoading value)?  detailLoading,TResult? Function( HomeDetailLoaded value)?  detailLoaded,TResult? Function( HomeError value)?  error,}){
final _that = this;
switch (_that) {
case HomeInitial() when initial != null:
return initial(_that);case HomeLoading() when loading != null:
return loading(_that);case HomeLoaded() when loaded != null:
return loaded(_that);case HomeDetailLoading() when detailLoading != null:
return detailLoading(_that);case HomeDetailLoaded() when detailLoaded != null:
return detailLoaded(_that);case HomeError() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( HomeEntity home,  DateTime lastRefresh)?  loaded,TResult Function()?  detailLoading,TResult Function( HomeEntity detail)?  detailLoaded,TResult Function( String message,  bool canRetry,  String? errorCode)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case HomeInitial() when initial != null:
return initial();case HomeLoading() when loading != null:
return loading();case HomeLoaded() when loaded != null:
return loaded(_that.home,_that.lastRefresh);case HomeDetailLoading() when detailLoading != null:
return detailLoading();case HomeDetailLoaded() when detailLoaded != null:
return detailLoaded(_that.detail);case HomeError() when error != null:
return error(_that.message,_that.canRetry,_that.errorCode);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( HomeEntity home,  DateTime lastRefresh)  loaded,required TResult Function()  detailLoading,required TResult Function( HomeEntity detail)  detailLoaded,required TResult Function( String message,  bool canRetry,  String? errorCode)  error,}) {final _that = this;
switch (_that) {
case HomeInitial():
return initial();case HomeLoading():
return loading();case HomeLoaded():
return loaded(_that.home,_that.lastRefresh);case HomeDetailLoading():
return detailLoading();case HomeDetailLoaded():
return detailLoaded(_that.detail);case HomeError():
return error(_that.message,_that.canRetry,_that.errorCode);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( HomeEntity home,  DateTime lastRefresh)?  loaded,TResult? Function()?  detailLoading,TResult? Function( HomeEntity detail)?  detailLoaded,TResult? Function( String message,  bool canRetry,  String? errorCode)?  error,}) {final _that = this;
switch (_that) {
case HomeInitial() when initial != null:
return initial();case HomeLoading() when loading != null:
return loading();case HomeLoaded() when loaded != null:
return loaded(_that.home,_that.lastRefresh);case HomeDetailLoading() when detailLoading != null:
return detailLoading();case HomeDetailLoaded() when detailLoaded != null:
return detailLoaded(_that.detail);case HomeError() when error != null:
return error(_that.message,_that.canRetry,_that.errorCode);case _:
  return null;

}
}

}

/// @nodoc


class HomeInitial implements HomeState {
  const HomeInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HomeState.initial()';
}


}




/// @nodoc


class HomeLoading implements HomeState {
  const HomeLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HomeState.loading()';
}


}




/// @nodoc


class HomeLoaded implements HomeState {
  const HomeLoaded({required this.home, required this.lastRefresh});
  

 final  HomeEntity home;
 final  DateTime lastRefresh;

/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeLoadedCopyWith<HomeLoaded> get copyWith => _$HomeLoadedCopyWithImpl<HomeLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeLoaded&&(identical(other.home, home) || other.home == home)&&(identical(other.lastRefresh, lastRefresh) || other.lastRefresh == lastRefresh));
}


@override
int get hashCode => Object.hash(runtimeType,home,lastRefresh);

@override
String toString() {
  return 'HomeState.loaded(home: $home, lastRefresh: $lastRefresh)';
}


}

/// @nodoc
abstract mixin class $HomeLoadedCopyWith<$Res> implements $HomeStateCopyWith<$Res> {
  factory $HomeLoadedCopyWith(HomeLoaded value, $Res Function(HomeLoaded) _then) = _$HomeLoadedCopyWithImpl;
@useResult
$Res call({
 HomeEntity home, DateTime lastRefresh
});




}
/// @nodoc
class _$HomeLoadedCopyWithImpl<$Res>
    implements $HomeLoadedCopyWith<$Res> {
  _$HomeLoadedCopyWithImpl(this._self, this._then);

  final HomeLoaded _self;
  final $Res Function(HomeLoaded) _then;

/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? home = null,Object? lastRefresh = null,}) {
  return _then(HomeLoaded(
home: null == home ? _self.home : home // ignore: cast_nullable_to_non_nullable
as HomeEntity,lastRefresh: null == lastRefresh ? _self.lastRefresh : lastRefresh // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

/// @nodoc


class HomeDetailLoading implements HomeState {
  const HomeDetailLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeDetailLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HomeState.detailLoading()';
}


}




/// @nodoc


class HomeDetailLoaded implements HomeState {
  const HomeDetailLoaded({required this.detail});
  

 final  HomeEntity detail;

/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeDetailLoadedCopyWith<HomeDetailLoaded> get copyWith => _$HomeDetailLoadedCopyWithImpl<HomeDetailLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeDetailLoaded&&(identical(other.detail, detail) || other.detail == detail));
}


@override
int get hashCode => Object.hash(runtimeType,detail);

@override
String toString() {
  return 'HomeState.detailLoaded(detail: $detail)';
}


}

/// @nodoc
abstract mixin class $HomeDetailLoadedCopyWith<$Res> implements $HomeStateCopyWith<$Res> {
  factory $HomeDetailLoadedCopyWith(HomeDetailLoaded value, $Res Function(HomeDetailLoaded) _then) = _$HomeDetailLoadedCopyWithImpl;
@useResult
$Res call({
 HomeEntity detail
});




}
/// @nodoc
class _$HomeDetailLoadedCopyWithImpl<$Res>
    implements $HomeDetailLoadedCopyWith<$Res> {
  _$HomeDetailLoadedCopyWithImpl(this._self, this._then);

  final HomeDetailLoaded _self;
  final $Res Function(HomeDetailLoaded) _then;

/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? detail = null,}) {
  return _then(HomeDetailLoaded(
detail: null == detail ? _self.detail : detail // ignore: cast_nullable_to_non_nullable
as HomeEntity,
  ));
}


}

/// @nodoc


class HomeError implements HomeState {
  const HomeError({required this.message, this.canRetry = false, this.errorCode});
  

 final  String message;
@JsonKey() final  bool canRetry;
 final  String? errorCode;

/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeErrorCopyWith<HomeError> get copyWith => _$HomeErrorCopyWithImpl<HomeError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeError&&(identical(other.message, message) || other.message == message)&&(identical(other.canRetry, canRetry) || other.canRetry == canRetry)&&(identical(other.errorCode, errorCode) || other.errorCode == errorCode));
}


@override
int get hashCode => Object.hash(runtimeType,message,canRetry,errorCode);

@override
String toString() {
  return 'HomeState.error(message: $message, canRetry: $canRetry, errorCode: $errorCode)';
}


}

/// @nodoc
abstract mixin class $HomeErrorCopyWith<$Res> implements $HomeStateCopyWith<$Res> {
  factory $HomeErrorCopyWith(HomeError value, $Res Function(HomeError) _then) = _$HomeErrorCopyWithImpl;
@useResult
$Res call({
 String message, bool canRetry, String? errorCode
});




}
/// @nodoc
class _$HomeErrorCopyWithImpl<$Res>
    implements $HomeErrorCopyWith<$Res> {
  _$HomeErrorCopyWithImpl(this._self, this._then);

  final HomeError _self;
  final $Res Function(HomeError) _then;

/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,Object? canRetry = null,Object? errorCode = freezed,}) {
  return _then(HomeError(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,canRetry: null == canRetry ? _self.canRetry : canRetry // ignore: cast_nullable_to_non_nullable
as bool,errorCode: freezed == errorCode ? _self.errorCode : errorCode // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
