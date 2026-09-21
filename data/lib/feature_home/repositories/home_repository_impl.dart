import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_boilerplate_core/flutter_boilerplate_core.dart';
import 'package:flutter_boilerplate_data/feature_home/datasources/home_remote_datasource.dart';
import 'package:flutter_boilerplate_data/feature_home/models/home_model.dart';
import 'package:flutter_boilerplate_domain/flutter_boilerplate_domain.dart';
import 'package:hive_ce/hive_ce.dart';
import 'package:injectable/injectable.dart';

/// Implementation of [HomeRepository]
///
/// This class orchestrates data operations by coordinating
/// between remote data source and local cache using Hive.
@LazySingleton(as: HomeRepository)
class HomeRepositoryImpl implements HomeRepository {
  /// Creates a new instance of [HomeRepositoryImpl]
  HomeRepositoryImpl({
    required HomeRemoteDatasource remoteDatasource,
    @Named('home_cache') required Box<String> cacheBox,
  }) : _remoteDatasource = remoteDatasource,
       _cacheBox = cacheBox;

  static const String _cacheKey = 'home_data';

  final HomeRemoteDatasource _remoteDatasource;
  final Box<String> _cacheBox;

  @override
  Future<Result<HomeEntity>> getHomeData() async {
    try {
      // Try to get from cache first
      final cachedData = _cacheBox.get(_cacheKey);
      if (cachedData != null) {
        final cachedModel = HomeModel.fromJson(
          jsonDecode(cachedData) as Map<String, dynamic>,
        );
        if (!cachedModel.isCached) {
          return (cachedModel.toEntity(), null);
        }
      }

      // Fetch from network
      final response = await _remoteDatasource.getHomeData();
      final homeModel = HomeModel(
        id: response.id,
        title: response.title,
        subtitle: response.subtitle,
        imageUrl: response.imageUrl,
        items: response.items,
        totalCount: response.totalCount,
        lastUpdated: response.lastUpdated,
      );

      // Cache the result
      await _cacheBox.put(_cacheKey, jsonEncode(homeModel.toJson()));

      return (homeModel.toEntity(), null);
    } on DioException catch (e) {
      // Try to return cached data on network failure
      final cachedJson = _cacheBox.get(_cacheKey);
      if (cachedJson != null) {
        final cachedModel = HomeModel.fromJson(
          jsonDecode(cachedJson) as Map<String, dynamic>,
        );
        return (cachedModel.toEntity(), null);
      }
      return (
        null,
        NetworkFailure(
          message: e.message ?? 'Network error',
          statusCode: e.response?.statusCode,
          responseBody: e.response?.toString(),
        ),
      );
    } catch (e, st) {
      return (
        null,
        UnknownFailure(
          message: 'Unexpected error: $e',
          exception: e,
          stackTrace: st,
        ),
      );
    }
  }

  @override
  Future<Result<HomeEntity>> getHomeDetail(String id) async {
    try {
      final response = await _remoteDatasource.getHomeDetail(id);
      final homeModel = HomeModel(
        id: response.id,
        title: response.title,
        subtitle: response.subtitle,
        imageUrl: response.imageUrl,
        items: response.items,
        totalCount: response.totalCount,
        lastUpdated: response.lastUpdated,
      );

      // Cache the detail
      await _cacheBox.put('home_detail_$id', jsonEncode(homeModel.toJson()));

      return (homeModel.toEntity(), null);
    } on DioException catch (e) {
      // Try cached data
      final cachedJson = _cacheBox.get('home_detail_$id');
      if (cachedJson != null) {
        final cachedModel = HomeModel.fromJson(
          jsonDecode(cachedJson) as Map<String, dynamic>,
        );
        return (cachedModel.toEntity(), null);
      }
      return (
        null,
        NetworkFailure(
          message: e.message ?? 'Network error',
          statusCode: e.response?.statusCode,
          responseBody: e.response?.toString(),
        ),
      );
    } catch (e, st) {
      return (
        null,
        UnknownFailure(
          message: 'Unexpected error: $e',
          exception: e,
          stackTrace: st,
        ),
      );
    }
  }

  @override
  Future<bool> hasCachedData() async {
    return _cacheBox.containsKey(_cacheKey);
  }

  @override
  Future<Result<void>> clearCache() async {
    try {
      await _cacheBox.delete(_cacheKey);
      // Also clear detail caches
      final keys = _cacheBox.keys
          .where((k) => k.toString().startsWith('home_detail_'))
          .toList();
      await _cacheBox.deleteAll(keys);
      return (null, null);
    } catch (e, st) {
      return (
        null,
        CacheFailure(message: 'Failed to clear cache: $e', stackTrace: st),
      );
    }
  }

  @override
  Stream<Result<HomeEntity>> watchHomeData() async* {
    // Watch the cache box for changes
    yield* _cacheBox.watch(key: _cacheKey).asyncMap((event) {
      final jsonString = event.value as String?;
      if (jsonString != null) {
        try {
          final model = HomeModel.fromJson(
            jsonDecode(jsonString) as Map<String, dynamic>,
          );
          return (model.toEntity(), null);
        } catch (e, st) {
          return (
            null,
            CacheFailure(
              message: 'Failed to deserialize cached data: $e',
              stackTrace: st,
            ),
          );
        }
      }
      return (null, const CacheFailure(message: 'No cached data available'));
    });
  }
}
