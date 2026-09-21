import 'package:injectable/injectable.dart';

/// Entry point for generating DI registrations for everything annotated
/// with `@injectable`/`@lazySingleton`/etc. inside this package's `lib/`.
///
/// Composed into the app-wide DI setup from `lib/src/injection/di.dart`.
@InjectableInit(initializerName: 'initDomain')
void configureDomainInjection() {}
