import 'package:flutter_boilerplate_data/feature_home/models/home_model.dart';
import 'package:flutter_boilerplate_domain/feature_home/entities/home_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('HomeItemModel', () {
    const tHomeItemModel = HomeItemModel(
      id: '1',
      title: 'Test Item',
      rank: 1,
      description: 'Test description',
      thumbnailUrl: 'https://example.com/thumb.jpg',
      category: 'test',
    );

    test('fromJson creates correct model', () {
      final json = <String, dynamic>{
        'id': '1',
        'title': 'Test Item',
        'rank': 1,
        'description': 'Test description',
        'thumbnailUrl': 'https://example.com/thumb.jpg',
        'category': 'test',
      };

      final model = HomeItemModel.fromJson(json);

      expect(model.id, '1');
      expect(model.title, 'Test Item');
      expect(model.rank, 1);
      expect(model.description, 'Test description');
      expect(model.isFeatured, false);
    });

    test('toJson produces correct map', () {
      final json = tHomeItemModel.toJson();

      expect(json['id'], '1');
      expect(json['title'], 'Test Item');
      expect(json['rank'], 1);
      expect(json['description'], 'Test description');
      expect(json['thumbnailUrl'], 'https://example.com/thumb.jpg');
      expect(json['category'], 'test');
      expect(json['isFeatured'], false);
    });

    test('toEntity maps to HomeItemEntity correctly', () {
      final entity = tHomeItemModel.toEntity();

      expect(entity, isA<HomeItemEntity>());
      expect(entity.id, tHomeItemModel.id);
      expect(entity.title, tHomeItemModel.title);
      expect(entity.rank, tHomeItemModel.rank);
      expect(entity.description, tHomeItemModel.description);
    });

    test('equality works with same values', () {
      const model1 = HomeItemModel(id: '1', title: 'Item', rank: 1);
      const model2 = HomeItemModel(id: '1', title: 'Item', rank: 1);

      expect(model1, model2);
    });
  });

  group('HomeModel', () {
    final tNow = DateTime(2024, 1, 1, 12);
    final tHomeModel = HomeModel(
      id: '1',
      title: 'Test Home',
      subtitle: 'Test Subtitle',
      imageUrl: 'https://example.com/image.jpg',
      items: const [HomeItemModel(id: '1', title: 'Test Item', rank: 1)],
      totalCount: 1,
      lastUpdated: tNow.toIso8601String(),
    );

    test('fromJson creates correct model', () {
      final json = <String, dynamic>{
        'id': '1',
        'title': 'Test Home',
        'subtitle': 'Test Subtitle',
        'imageUrl': 'https://example.com/image.jpg',
        'items': [
          <String, dynamic>{'id': '1', 'title': 'Test Item', 'rank': 1},
        ],
        'totalCount': 1,
        'lastUpdated': tNow.toIso8601String(),
        'isCached': false,
      };

      final model = HomeModel.fromJson(json);

      expect(model.id, '1');
      expect(model.title, 'Test Home');
      expect(model.subtitle, 'Test Subtitle');
      expect(model.totalCount, 1);
      expect(model.items.length, 1);
    });

    test('toJson produces correct map', () {
      final json = tHomeModel.toJson();

      expect(json['id'], '1');
      expect(json['title'], 'Test Home');
      expect(json['subtitle'], 'Test Subtitle');
      expect(json['imageUrl'], 'https://example.com/image.jpg');
      expect(json['totalCount'], 1);
      expect(json['items'], isA<List<dynamic>>());
      expect(json['lastUpdated'], tNow.toIso8601String());
    });

    test('toEntity maps to HomeEntity correctly', () {
      final entity = tHomeModel.toEntity();

      expect(entity, isA<HomeEntity>());
      expect(entity.id, tHomeModel.id);
      expect(entity.title, tHomeModel.title);
      expect(entity.subtitle, tHomeModel.subtitle);
      expect(entity.totalCount, tHomeModel.totalCount);
      expect(entity.items.length, tHomeModel.items.length);
    });

    test('isCached defaults to false', () {
      const model = HomeModel(
        id: '1',
        title: 'Home',
        items: <HomeItemModel>[],
        totalCount: 0,
        lastUpdated: '2024-01-01T12:00:00.000Z',
      );

      expect(model.isCached, false);
    });

    test('isCached can be set to true', () {
      const model = HomeModel(
        id: '1',
        title: 'Home',
        items: <HomeItemModel>[],
        totalCount: 0,
        lastUpdated: '2024-01-01T12:00:00.000Z',
        isCached: true,
      );

      expect(model.isCached, true);
    });

    test('equality works with same values', () {
      final model1 = HomeModel(
        id: '1',
        title: 'Home',
        items: const <HomeItemModel>[],
        totalCount: 0,
        lastUpdated: tNow.toIso8601String(),
      );
      final model2 = HomeModel(
        id: '1',
        title: 'Home',
        items: const <HomeItemModel>[],
        totalCount: 0,
        lastUpdated: tNow.toIso8601String(),
      );

      expect(model1, model2);
    });
  });

  group('HomeDetailModel', () {
    final tNow = DateTime(2024, 1, 1, 12);

    test('fromJson creates correct model with metadata', () {
      final json = <String, dynamic>{
        'id': '1',
        'title': 'Test Detail',
        'items': <dynamic>[],
        'totalCount': 0,
        'lastUpdated': tNow.toIso8601String(),
        'description': 'Detail description',
        'metadata': {'key': 'value'},
      };

      final model = HomeDetailModel.fromJson(json);

      expect(model.id, '1');
      expect(model.description, 'Detail description');
      expect(model.metadata, {'key': 'value'});
    });

    test('toEntity maps to HomeEntity correctly', () {
      final model = HomeDetailModel(
        id: '1',
        title: 'Detail',
        items: const [],
        totalCount: 0,
        lastUpdated: tNow.toIso8601String(),
        description: 'Test description',
      );

      final entity = model.toEntity();

      expect(entity, isA<HomeEntity>());
      expect(entity.id, '1');
      expect(entity.title, 'Detail');
    });
  });
}
