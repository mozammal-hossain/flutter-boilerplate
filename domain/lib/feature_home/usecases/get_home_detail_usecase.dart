import 'package:flutter_boilerplate_core/flutter_boilerplate_core.dart';
import 'package:flutter_boilerplate_domain/feature_home/entities/home_entity.dart';
import 'package:flutter_boilerplate_domain/feature_home/repositories/home_repository.dart';
import 'package:injectable/injectable.dart';

/// Use case for fetching home detail by ID
///
/// Encapsulates the business logic for retrieving detailed
/// information about a specific home item.
@injectable
class GetHomeDetailUseCase {
  /// Creates a new instance of GetHomeDetailUseCase
  const GetHomeDetailUseCase(this._repository);

  final HomeRepository _repository;

  /// Execute the use case
  ///
  /// [id] - Unique identifier for the item
  Future<Result<HomeEntity>> call(String id) => _repository.getHomeDetail(id);
}
