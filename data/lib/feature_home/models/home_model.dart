import 'package:flutter_boilerplate_domain/flutter_boilerplate_domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_model.freezed.dart';
part 'home_model.g.dart';

/// Data model for home items
///
/// This is the data layer representation of a home item.
/// Used for JSON serialization/deserialization.
@freezed
abstract class HomeItemModel with _$HomeItemModel {
  /// Creates an instance of [HomeItemModel]
  ///
  /// [id] - unique identifier for the item
  /// [title] - display title
  /// [description] - optional description
  /// [thumbnailUrl] - optional thumbnail image URL
  /// [category] - optional category
  /// [rank] - display rank/order
  /// [isFeatured] - whether the item is featured
  const factory HomeItemModel({
    required String id,
    required String title,
    required int rank,
    String? description,
    String? thumbnailUrl,
    String? category,
    @Default(false) bool isFeatured,
  }) = _HomeItemModel;

  /// Creates a [HomeItemModel] from JSON map
  factory HomeItemModel.fromJson(Map<String, dynamic> json) =>
      _$HomeItemModelFromJson(json);
}

/// Data model for home entity
///
/// This is the data layer representation of home data.
/// Used for network responses and local storage.
@freezed
abstract class HomeModel with _$HomeModel {
  /// Creates an instance of [HomeModel]
  ///
  /// [id] - unique identifier for the home data
  /// [title] - display title
  /// [subtitle] - optional subtitle
  /// [imageUrl] - optional header image URL
  /// [items] - list of home items
  /// [totalCount] - total number of items
  /// [lastUpdated] - ISO 8601 timestamp of last update
  /// [isCached] - whether the data is cached
  const factory HomeModel({
    required String id,
    required String title,
    required List<HomeItemModel> items,
    required int totalCount,
    required String lastUpdated,
    String? subtitle,
    String? imageUrl,
    @Default(false) bool isCached,
  }) = _HomeModel;

  /// Creates a [HomeModel] from JSON map
  factory HomeModel.fromJson(Map<String, dynamic> json) =>
      _$HomeModelFromJson(json);
}

/// Data model for home detail - extends HomeModel with additional fields
@freezed
abstract class HomeDetailModel with _$HomeDetailModel {
  /// Creates an instance of [HomeDetailModel]
  ///
  /// [description] - optional detailed description
  /// [metadata] - optional additional metadata
  const factory HomeDetailModel({
    required String id,
    required String title,
    required List<HomeItemModel> items,
    required int totalCount,
    required String lastUpdated,
    String? subtitle,
    String? imageUrl,
    @Default(false) bool isCached,
    String? description,
    Map<String, dynamic>? metadata,
  }) = _HomeDetailModel;

  /// Creates a [HomeDetailModel] from JSON map
  factory HomeDetailModel.fromJson(Map<String, dynamic> json) =>
      _$HomeDetailModelFromJson(json);
}

/// Extension methods to convert between data models and domain entities
extension HomeModelX on HomeModel {
  /// Convert data model to domain entity
  HomeEntity toEntity() {
    return HomeEntity(
      id: id,
      title: title,
      subtitle: subtitle,
      imageUrl: imageUrl,
      items: items.map((e) => e.toEntity()).toList(),
      totalCount: totalCount,
      lastUpdated: DateTime.parse(lastUpdated),
      isCached: isCached,
    );
  }
}

/// Extension methods to convert between data models and domain entities
extension HomeItemModelX on HomeItemModel {
  /// Convert data model to domain entity
  HomeItemEntity toEntity() {
    return HomeItemEntity(
      id: id,
      title: title,
      description: description,
      thumbnailUrl: thumbnailUrl,
      category: category,
      rank: rank,
      isFeatured: isFeatured,
    );
  }
}

/// Extension methods to convert between data models and domain entities
extension HomeDetailModelX on HomeDetailModel {
  /// Convert data model to domain entity
  HomeEntity toEntity() {
    return HomeEntity(
      id: id,
      title: title,
      subtitle: subtitle,
      imageUrl: imageUrl,
      items: items.map((e) => e.toEntity()).toList(),
      totalCount: totalCount,
      lastUpdated: DateTime.parse(lastUpdated),
      isCached: isCached,
    );
  }
}
