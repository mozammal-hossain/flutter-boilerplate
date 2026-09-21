import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boilerplate/routes/app_router.dart';
import 'package:flutter_boilerplate/src/injection/di.dart' as di;
import 'package:flutter_boilerplate_core/utils/bloc_observer.dart';
import 'package:flutter_boilerplate_core/utils/network/api_client.dart';
import 'package:flutter_boilerplate_core/utils/storage/local_storage.dart';
import 'package:flutter_boilerplate_core/utils/theme/app_theme.dart';
import 'package:flutter_boilerplate_domain/feature_home/entities/home_entity.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:mockito/mockito.dart';

/// Helper function to pump the app with optional dependency overrides
Future<void> pumpApp(WidgetTester tester, {Widget? overrideWidget}) async {
  // Reset GetIt to ensure clean state for each test
  await GetIt.instance.reset();

  // Configure dependencies
  await di.configureDependencies();

  // Set bloc observer
  Bloc.observer = SimpleBlocObserver();

  // Build the app
  final widget =
      overrideWidget ??
      ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp.router(
            title: 'Flutter Boilerplate',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            routerConfig: AppRouter.getRouter(
              isLoggedIn: () async {
                final (token, _) = await GetIt.instance<LocalStorage>()
                    .get<String>('auth_token');
                return token != null && token.isNotEmpty;
              },
            ),
            builder: (context, child) {
              return MediaQuery(
                data: MediaQuery.of(
                  context,
                ).copyWith(textScaler: TextScaler.noScaling),
                child: child!,
              );
            },
          );
        },
      );

  await tester.pumpWidget(widget);
  await tester.pumpAndSettle();
}

/// Creates a mock LocalStorage instance
MockLocalStorage createMockLocalStorage() {
  return MockLocalStorage();
}

/// Mock for LocalStorage
class MockLocalStorage extends Mock implements LocalStorage {}

/// Mock for ApiClient
class MockApiClient extends Mock implements ApiClient {}

/// Mock for Logger
class MockLogger extends Mock implements Logger {}

/// Test data fixtures
class TestData {
  static final tNow = DateTime(2024, 1, 1, 12);

  static const tHomeItemEntity = HomeItemEntity(
    id: '1',
    title: 'Test Item 1',
    rank: 1,
    description: 'Test description',
    thumbnailUrl: 'https://example.com/thumb.jpg',
    category: 'test',
    isFeatured: true,
  );

  static final tHomeEntity = HomeEntity(
    id: '1',
    title: 'Test Home',
    subtitle: 'Test Subtitle',
    imageUrl: 'https://example.com/image.jpg',
    items: const [tHomeItemEntity],
    totalCount: 1,
    lastUpdated: tNow,
  );

  static Map<String, dynamic> tHomeJson() => {
    'id': '1',
    'title': 'Test Home',
    'subtitle': 'Test Subtitle',
    'imageUrl': 'https://example.com/image.jpg',
    'items': [
      {
        'id': '1',
        'title': 'Test Item 1',
        'rank': 1,
        'description': 'Test description',
        'thumbnailUrl': 'https://example.com/thumb.jpg',
        'category': 'test',
        'isFeatured': true,
      },
    ],
    'totalCount': 1,
    'lastUpdated': tNow.toIso8601String(),
    'isCached': false,
  };

  static Map<String, dynamic> tHomeJsonWithCached() => {
    ...tHomeJson(),
    'isCached': true,
  };
}
