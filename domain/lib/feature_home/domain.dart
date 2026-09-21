/// Domain layer for Home feature
///
/// Contains business logic entities, use cases, and repository interfaces.
/// This layer is independent of any framework or implementation details.
library home_domain;

// Entities
export 'entities/home_entity.dart';

// Repository interface
export 'repositories/home_repository.dart';

// Use cases
export 'usecases/get_home_data_usecase.dart';
export 'usecases/get_home_detail_usecase.dart';
