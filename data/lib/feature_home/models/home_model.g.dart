// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_HomeItemModel _$HomeItemModelFromJson(Map<String, dynamic> json) =>
    _HomeItemModel(
      id: json['id'] as String,
      title: json['title'] as String,
      rank: (json['rank'] as num).toInt(),
      description: json['description'] as String?,
      thumbnailUrl: json['thumbnailUrl'] as String?,
      category: json['category'] as String?,
      isFeatured: json['isFeatured'] as bool? ?? false,
    );

Map<String, dynamic> _$HomeItemModelToJson(_HomeItemModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'rank': instance.rank,
      'description': instance.description,
      'thumbnailUrl': instance.thumbnailUrl,
      'category': instance.category,
      'isFeatured': instance.isFeatured,
    };

_HomeModel _$HomeModelFromJson(Map<String, dynamic> json) => _HomeModel(
  id: json['id'] as String,
  title: json['title'] as String,
  items: (json['items'] as List<dynamic>)
      .map((e) => HomeItemModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  totalCount: (json['totalCount'] as num).toInt(),
  lastUpdated: json['lastUpdated'] as String,
  subtitle: json['subtitle'] as String?,
  imageUrl: json['imageUrl'] as String?,
  isCached: json['isCached'] as bool? ?? false,
);

Map<String, dynamic> _$HomeModelToJson(_HomeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'items': instance.items,
      'totalCount': instance.totalCount,
      'lastUpdated': instance.lastUpdated,
      'subtitle': instance.subtitle,
      'imageUrl': instance.imageUrl,
      'isCached': instance.isCached,
    };

_HomeDetailModel _$HomeDetailModelFromJson(Map<String, dynamic> json) =>
    _HomeDetailModel(
      id: json['id'] as String,
      title: json['title'] as String,
      items: (json['items'] as List<dynamic>)
          .map((e) => HomeItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalCount: (json['totalCount'] as num).toInt(),
      lastUpdated: json['lastUpdated'] as String,
      subtitle: json['subtitle'] as String?,
      imageUrl: json['imageUrl'] as String?,
      isCached: json['isCached'] as bool? ?? false,
      description: json['description'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$HomeDetailModelToJson(_HomeDetailModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'items': instance.items,
      'totalCount': instance.totalCount,
      'lastUpdated': instance.lastUpdated,
      'subtitle': instance.subtitle,
      'imageUrl': instance.imageUrl,
      'isCached': instance.isCached,
      'description': instance.description,
      'metadata': instance.metadata,
    };
