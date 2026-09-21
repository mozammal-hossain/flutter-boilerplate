import 'package:dio/dio.dart';
import 'package:flutter_boilerplate_data/feature_home/models/home_model.dart';
import 'package:retrofit/retrofit.dart';

part 'home_remote_datasource.g.dart';

/// Remote data source for home feature API calls
///
/// Uses Retrofit for type-safe HTTP client generation.
/// All endpoints are defined as abstract methods.
@RestApi()
abstract class HomeRemoteDatasource {
  /// Creates an instance of [HomeRemoteDatasource]
  ///
  /// [dio] - configured Dio instance with interceptors
  factory HomeRemoteDatasource(Dio dio, {String baseUrl}) =
      _HomeRemoteDatasource;

  /// GET /home
  /// Fetch home screen data
  @GET('/home')
  Future<HomeModel> getHomeData();

  /// GET /home/{id}
  /// Fetch detailed home data by ID
  @GET('/home/{id}')
  Future<HomeDetailModel> getHomeDetail(@Path('id') String id);
}
