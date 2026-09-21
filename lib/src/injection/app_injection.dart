import 'package:injectable/injectable.dart';

/// Entry point for generating DI registrations for everything annotated
/// with `@injectable`/`@lazySingleton`/etc. inside the app's own `lib/`
/// (e.g. feature Cubits/Blocs).
///
/// Composed into the app-wide DI setup from `lib/src/injection/di.dart`.
@InjectableInit(initializerName: 'initApp')
void configureAppInjection() {}
