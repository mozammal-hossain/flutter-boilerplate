// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$HomeItemModel {

 String get id; String get title; int get rank; String? get description; String? get thumbnailUrl; String? get category; bool get isFeatured;
/// Create a copy of HomeItemModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeItemModelCopyWith<HomeItemModel> get copyWith => _$HomeItemModelCopyWithImpl<HomeItemModel>(this as HomeItemModel, _$identity);

  /// Serializes this HomeItemModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeItemModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.rank, rank) || other.rank == rank)&&(identical(other.description, description) || other.description == description)&&(identical(other.thumbnailUrl, thumbnailUrl) || other.thumbnailUrl == thumbnailUrl)&&(identical(other.category, category) || other.category == category)&&(identical(other.isFeatured, isFeatured) || other.isFeatured == isFeatured));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,rank,description,thumbnailUrl,category,isFeatured);

@override
String toString() {
  return 'HomeItemModel(id: $id, title: $title, rank: $rank, description: $description, thumbnailUrl: $thumbnailUrl, category: $category, isFeatured: $isFeatured)';
}


}

/// @nodoc
abstract mixin class $HomeItemModelCopyWith<$Res>  {
  factory $HomeItemModelCopyWith(HomeItemModel value, $Res Function(HomeItemModel) _then) = _$HomeItemModelCopyWithImpl;
@useResult
$Res call({
 String id, String title, int rank, String? description, String? thumbnailUrl, String? category, bool isFeatured
});




}
/// @nodoc
class _$HomeItemModelCopyWithImpl<$Res>
    implements $HomeItemModelCopyWith<$Res> {
  _$HomeItemModelCopyWithImpl(this._self, this._then);

  final HomeItemModel _self;
  final $Res Function(HomeItemModel) _then;

/// Create a copy of HomeItemModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? rank = null,Object? description = freezed,Object? thumbnailUrl = freezed,Object? category = freezed,Object? isFeatured = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,rank: null == rank ? _self.rank : rank // ignore: cast_nullable_to_non_nullable
as int,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,thumbnailUrl: freezed == thumbnailUrl ? _self.thumbnailUrl : thumbnailUrl // ignore: cast_nullable_to_non_nullable
as String?,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,isFeatured: null == isFeatured ? _self.isFeatured : isFeatured // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [HomeItemModel].
extension HomeItemModelPatterns on HomeItemModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HomeItemModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HomeItemModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HomeItemModel value)  $default,){
final _that = this;
switch (_that) {
case _HomeItemModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HomeItemModel value)?  $default,){
final _that = this;
switch (_that) {
case _HomeItemModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  int rank,  String? description,  String? thumbnailUrl,  String? category,  bool isFeatured)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HomeItemModel() when $default != null:
return $default(_that.id,_that.title,_that.rank,_that.description,_that.thumbnailUrl,_that.category,_that.isFeatured);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  int rank,  String? description,  String? thumbnailUrl,  String? category,  bool isFeatured)  $default,) {final _that = this;
switch (_that) {
case _HomeItemModel():
return $default(_that.id,_that.title,_that.rank,_that.description,_that.thumbnailUrl,_that.category,_that.isFeatured);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  int rank,  String? description,  String? thumbnailUrl,  String? category,  bool isFeatured)?  $default,) {final _that = this;
switch (_that) {
case _HomeItemModel() when $default != null:
return $default(_that.id,_that.title,_that.rank,_that.description,_that.thumbnailUrl,_that.category,_that.isFeatured);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HomeItemModel implements HomeItemModel {
  const _HomeItemModel({required this.id, required this.title, required this.rank, this.description, this.thumbnailUrl, this.category, this.isFeatured = false});
  factory _HomeItemModel.fromJson(Map<String, dynamic> json) => _$HomeItemModelFromJson(json);

@override final  String id;
@override final  String title;
@override final  int rank;
@override final  String? description;
@override final  String? thumbnailUrl;
@override final  String? category;
@override@JsonKey() final  bool isFeatured;

/// Create a copy of HomeItemModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HomeItemModelCopyWith<_HomeItemModel> get copyWith => __$HomeItemModelCopyWithImpl<_HomeItemModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HomeItemModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HomeItemModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.rank, rank) || other.rank == rank)&&(identical(other.description, description) || other.description == description)&&(identical(other.thumbnailUrl, thumbnailUrl) || other.thumbnailUrl == thumbnailUrl)&&(identical(other.category, category) || other.category == category)&&(identical(other.isFeatured, isFeatured) || other.isFeatured == isFeatured));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,rank,description,thumbnailUrl,category,isFeatured);

@override
String toString() {
  return 'HomeItemModel(id: $id, title: $title, rank: $rank, description: $description, thumbnailUrl: $thumbnailUrl, category: $category, isFeatured: $isFeatured)';
}


}

/// @nodoc
abstract mixin class _$HomeItemModelCopyWith<$Res> implements $HomeItemModelCopyWith<$Res> {
  factory _$HomeItemModelCopyWith(_HomeItemModel value, $Res Function(_HomeItemModel) _then) = __$HomeItemModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, int rank, String? description, String? thumbnailUrl, String? category, bool isFeatured
});




}
/// @nodoc
class __$HomeItemModelCopyWithImpl<$Res>
    implements _$HomeItemModelCopyWith<$Res> {
  __$HomeItemModelCopyWithImpl(this._self, this._then);

  final _HomeItemModel _self;
  final $Res Function(_HomeItemModel) _then;

/// Create a copy of HomeItemModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? rank = null,Object? description = freezed,Object? thumbnailUrl = freezed,Object? category = freezed,Object? isFeatured = null,}) {
  return _then(_HomeItemModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,rank: null == rank ? _self.rank : rank // ignore: cast_nullable_to_non_nullable
as int,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,thumbnailUrl: freezed == thumbnailUrl ? _self.thumbnailUrl : thumbnailUrl // ignore: cast_nullable_to_non_nullable
as String?,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,isFeatured: null == isFeatured ? _self.isFeatured : isFeatured // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$HomeModel {

 String get id; String get title; List<HomeItemModel> get items; int get totalCount; String get lastUpdated; String? get subtitle; String? get imageUrl; bool get isCached;
/// Create a copy of HomeModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeModelCopyWith<HomeModel> get copyWith => _$HomeModelCopyWithImpl<HomeModel>(this as HomeModel, _$identity);

  /// Serializes this HomeModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other.items, items)&&(identical(other.totalCount, totalCount) || other.totalCount == totalCount)&&(identical(other.lastUpdated, lastUpdated) || other.lastUpdated == lastUpdated)&&(identical(other.subtitle, subtitle) || other.subtitle == subtitle)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.isCached, isCached) || other.isCached == isCached));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,const DeepCollectionEquality().hash(items),totalCount,lastUpdated,subtitle,imageUrl,isCached);

@override
String toString() {
  return 'HomeModel(id: $id, title: $title, items: $items, totalCount: $totalCount, lastUpdated: $lastUpdated, subtitle: $subtitle, imageUrl: $imageUrl, isCached: $isCached)';
}


}

/// @nodoc
abstract mixin class $HomeModelCopyWith<$Res>  {
  factory $HomeModelCopyWith(HomeModel value, $Res Function(HomeModel) _then) = _$HomeModelCopyWithImpl;
@useResult
$Res call({
 String id, String title, List<HomeItemModel> items, int totalCount, String lastUpdated, String? subtitle, String? imageUrl, bool isCached
});




}
/// @nodoc
class _$HomeModelCopyWithImpl<$Res>
    implements $HomeModelCopyWith<$Res> {
  _$HomeModelCopyWithImpl(this._self, this._then);

  final HomeModel _self;
  final $Res Function(HomeModel) _then;

/// Create a copy of HomeModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? items = null,Object? totalCount = null,Object? lastUpdated = null,Object? subtitle = freezed,Object? imageUrl = freezed,Object? isCached = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<HomeItemModel>,totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int,lastUpdated: null == lastUpdated ? _self.lastUpdated : lastUpdated // ignore: cast_nullable_to_non_nullable
as String,subtitle: freezed == subtitle ? _self.subtitle : subtitle // ignore: cast_nullable_to_non_nullable
as String?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,isCached: null == isCached ? _self.isCached : isCached // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [HomeModel].
extension HomeModelPatterns on HomeModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HomeModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HomeModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HomeModel value)  $default,){
final _that = this;
switch (_that) {
case _HomeModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HomeModel value)?  $default,){
final _that = this;
switch (_that) {
case _HomeModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  List<HomeItemModel> items,  int totalCount,  String lastUpdated,  String? subtitle,  String? imageUrl,  bool isCached)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HomeModel() when $default != null:
return $default(_that.id,_that.title,_that.items,_that.totalCount,_that.lastUpdated,_that.subtitle,_that.imageUrl,_that.isCached);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  List<HomeItemModel> items,  int totalCount,  String lastUpdated,  String? subtitle,  String? imageUrl,  bool isCached)  $default,) {final _that = this;
switch (_that) {
case _HomeModel():
return $default(_that.id,_that.title,_that.items,_that.totalCount,_that.lastUpdated,_that.subtitle,_that.imageUrl,_that.isCached);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  List<HomeItemModel> items,  int totalCount,  String lastUpdated,  String? subtitle,  String? imageUrl,  bool isCached)?  $default,) {final _that = this;
switch (_that) {
case _HomeModel() when $default != null:
return $default(_that.id,_that.title,_that.items,_that.totalCount,_that.lastUpdated,_that.subtitle,_that.imageUrl,_that.isCached);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HomeModel implements HomeModel {
  const _HomeModel({required this.id, required this.title, required final  List<HomeItemModel> items, required this.totalCount, required this.lastUpdated, this.subtitle, this.imageUrl, this.isCached = false}): _items = items;
  factory _HomeModel.fromJson(Map<String, dynamic> json) => _$HomeModelFromJson(json);

@override final  String id;
@override final  String title;
 final  List<HomeItemModel> _items;
@override List<HomeItemModel> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override final  int totalCount;
@override final  String lastUpdated;
@override final  String? subtitle;
@override final  String? imageUrl;
@override@JsonKey() final  bool isCached;

/// Create a copy of HomeModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HomeModelCopyWith<_HomeModel> get copyWith => __$HomeModelCopyWithImpl<_HomeModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HomeModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HomeModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.totalCount, totalCount) || other.totalCount == totalCount)&&(identical(other.lastUpdated, lastUpdated) || other.lastUpdated == lastUpdated)&&(identical(other.subtitle, subtitle) || other.subtitle == subtitle)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.isCached, isCached) || other.isCached == isCached));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,const DeepCollectionEquality().hash(_items),totalCount,lastUpdated,subtitle,imageUrl,isCached);

@override
String toString() {
  return 'HomeModel(id: $id, title: $title, items: $items, totalCount: $totalCount, lastUpdated: $lastUpdated, subtitle: $subtitle, imageUrl: $imageUrl, isCached: $isCached)';
}


}

/// @nodoc
abstract mixin class _$HomeModelCopyWith<$Res> implements $HomeModelCopyWith<$Res> {
  factory _$HomeModelCopyWith(_HomeModel value, $Res Function(_HomeModel) _then) = __$HomeModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, List<HomeItemModel> items, int totalCount, String lastUpdated, String? subtitle, String? imageUrl, bool isCached
});




}
/// @nodoc
class __$HomeModelCopyWithImpl<$Res>
    implements _$HomeModelCopyWith<$Res> {
  __$HomeModelCopyWithImpl(this._self, this._then);

  final _HomeModel _self;
  final $Res Function(_HomeModel) _then;

/// Create a copy of HomeModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? items = null,Object? totalCount = null,Object? lastUpdated = null,Object? subtitle = freezed,Object? imageUrl = freezed,Object? isCached = null,}) {
  return _then(_HomeModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<HomeItemModel>,totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int,lastUpdated: null == lastUpdated ? _self.lastUpdated : lastUpdated // ignore: cast_nullable_to_non_nullable
as String,subtitle: freezed == subtitle ? _self.subtitle : subtitle // ignore: cast_nullable_to_non_nullable
as String?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,isCached: null == isCached ? _self.isCached : isCached // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$HomeDetailModel {

 String get id; String get title; List<HomeItemModel> get items; int get totalCount; String get lastUpdated; String? get subtitle; String? get imageUrl; bool get isCached; String? get description; Map<String, dynamic>? get metadata;
/// Create a copy of HomeDetailModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeDetailModelCopyWith<HomeDetailModel> get copyWith => _$HomeDetailModelCopyWithImpl<HomeDetailModel>(this as HomeDetailModel, _$identity);

  /// Serializes this HomeDetailModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeDetailModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other.items, items)&&(identical(other.totalCount, totalCount) || other.totalCount == totalCount)&&(identical(other.lastUpdated, lastUpdated) || other.lastUpdated == lastUpdated)&&(identical(other.subtitle, subtitle) || other.subtitle == subtitle)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.isCached, isCached) || other.isCached == isCached)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other.metadata, metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,const DeepCollectionEquality().hash(items),totalCount,lastUpdated,subtitle,imageUrl,isCached,description,const DeepCollectionEquality().hash(metadata));

@override
String toString() {
  return 'HomeDetailModel(id: $id, title: $title, items: $items, totalCount: $totalCount, lastUpdated: $lastUpdated, subtitle: $subtitle, imageUrl: $imageUrl, isCached: $isCached, description: $description, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class $HomeDetailModelCopyWith<$Res>  {
  factory $HomeDetailModelCopyWith(HomeDetailModel value, $Res Function(HomeDetailModel) _then) = _$HomeDetailModelCopyWithImpl;
@useResult
$Res call({
 String id, String title, List<HomeItemModel> items, int totalCount, String lastUpdated, String? subtitle, String? imageUrl, bool isCached, String? description, Map<String, dynamic>? metadata
});




}
/// @nodoc
class _$HomeDetailModelCopyWithImpl<$Res>
    implements $HomeDetailModelCopyWith<$Res> {
  _$HomeDetailModelCopyWithImpl(this._self, this._then);

  final HomeDetailModel _self;
  final $Res Function(HomeDetailModel) _then;

/// Create a copy of HomeDetailModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? items = null,Object? totalCount = null,Object? lastUpdated = null,Object? subtitle = freezed,Object? imageUrl = freezed,Object? isCached = null,Object? description = freezed,Object? metadata = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<HomeItemModel>,totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int,lastUpdated: null == lastUpdated ? _self.lastUpdated : lastUpdated // ignore: cast_nullable_to_non_nullable
as String,subtitle: freezed == subtitle ? _self.subtitle : subtitle // ignore: cast_nullable_to_non_nullable
as String?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,isCached: null == isCached ? _self.isCached : isCached // ignore: cast_nullable_to_non_nullable
as bool,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,metadata: freezed == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}

}


/// Adds pattern-matching-related methods to [HomeDetailModel].
extension HomeDetailModelPatterns on HomeDetailModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HomeDetailModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HomeDetailModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HomeDetailModel value)  $default,){
final _that = this;
switch (_that) {
case _HomeDetailModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HomeDetailModel value)?  $default,){
final _that = this;
switch (_that) {
case _HomeDetailModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  List<HomeItemModel> items,  int totalCount,  String lastUpdated,  String? subtitle,  String? imageUrl,  bool isCached,  String? description,  Map<String, dynamic>? metadata)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HomeDetailModel() when $default != null:
return $default(_that.id,_that.title,_that.items,_that.totalCount,_that.lastUpdated,_that.subtitle,_that.imageUrl,_that.isCached,_that.description,_that.metadata);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  List<HomeItemModel> items,  int totalCount,  String lastUpdated,  String? subtitle,  String? imageUrl,  bool isCached,  String? description,  Map<String, dynamic>? metadata)  $default,) {final _that = this;
switch (_that) {
case _HomeDetailModel():
return $default(_that.id,_that.title,_that.items,_that.totalCount,_that.lastUpdated,_that.subtitle,_that.imageUrl,_that.isCached,_that.description,_that.metadata);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  List<HomeItemModel> items,  int totalCount,  String lastUpdated,  String? subtitle,  String? imageUrl,  bool isCached,  String? description,  Map<String, dynamic>? metadata)?  $default,) {final _that = this;
switch (_that) {
case _HomeDetailModel() when $default != null:
return $default(_that.id,_that.title,_that.items,_that.totalCount,_that.lastUpdated,_that.subtitle,_that.imageUrl,_that.isCached,_that.description,_that.metadata);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HomeDetailModel implements HomeDetailModel {
  const _HomeDetailModel({required this.id, required this.title, required final  List<HomeItemModel> items, required this.totalCount, required this.lastUpdated, this.subtitle, this.imageUrl, this.isCached = false, this.description, final  Map<String, dynamic>? metadata}): _items = items,_metadata = metadata;
  factory _HomeDetailModel.fromJson(Map<String, dynamic> json) => _$HomeDetailModelFromJson(json);

@override final  String id;
@override final  String title;
 final  List<HomeItemModel> _items;
@override List<HomeItemModel> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override final  int totalCount;
@override final  String lastUpdated;
@override final  String? subtitle;
@override final  String? imageUrl;
@override@JsonKey() final  bool isCached;
@override final  String? description;
 final  Map<String, dynamic>? _metadata;
@override Map<String, dynamic>? get metadata {
  final value = _metadata;
  if (value == null) return null;
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of HomeDetailModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HomeDetailModelCopyWith<_HomeDetailModel> get copyWith => __$HomeDetailModelCopyWithImpl<_HomeDetailModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HomeDetailModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HomeDetailModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.totalCount, totalCount) || other.totalCount == totalCount)&&(identical(other.lastUpdated, lastUpdated) || other.lastUpdated == lastUpdated)&&(identical(other.subtitle, subtitle) || other.subtitle == subtitle)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.isCached, isCached) || other.isCached == isCached)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other._metadata, _metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,const DeepCollectionEquality().hash(_items),totalCount,lastUpdated,subtitle,imageUrl,isCached,description,const DeepCollectionEquality().hash(_metadata));

@override
String toString() {
  return 'HomeDetailModel(id: $id, title: $title, items: $items, totalCount: $totalCount, lastUpdated: $lastUpdated, subtitle: $subtitle, imageUrl: $imageUrl, isCached: $isCached, description: $description, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class _$HomeDetailModelCopyWith<$Res> implements $HomeDetailModelCopyWith<$Res> {
  factory _$HomeDetailModelCopyWith(_HomeDetailModel value, $Res Function(_HomeDetailModel) _then) = __$HomeDetailModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, List<HomeItemModel> items, int totalCount, String lastUpdated, String? subtitle, String? imageUrl, bool isCached, String? description, Map<String, dynamic>? metadata
});




}
/// @nodoc
class __$HomeDetailModelCopyWithImpl<$Res>
    implements _$HomeDetailModelCopyWith<$Res> {
  __$HomeDetailModelCopyWithImpl(this._self, this._then);

  final _HomeDetailModel _self;
  final $Res Function(_HomeDetailModel) _then;

/// Create a copy of HomeDetailModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? items = null,Object? totalCount = null,Object? lastUpdated = null,Object? subtitle = freezed,Object? imageUrl = freezed,Object? isCached = null,Object? description = freezed,Object? metadata = freezed,}) {
  return _then(_HomeDetailModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<HomeItemModel>,totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int,lastUpdated: null == lastUpdated ? _self.lastUpdated : lastUpdated // ignore: cast_nullable_to_non_nullable
as String,subtitle: freezed == subtitle ? _self.subtitle : subtitle // ignore: cast_nullable_to_non_nullable
as String?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,isCached: null == isCached ? _self.isCached : isCached // ignore: cast_nullable_to_non_nullable
as bool,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,metadata: freezed == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}


}

// dart format on
