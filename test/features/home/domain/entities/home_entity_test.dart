import 'package:flutter_boilerplate_domain/feature_home/entities/home_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('HomeEntity', () {
    const tHomeItemEntity = HomeItemEntity(
      id: '1',
      title: 'Test Item',
      rank: 1,
      description: 'Test description',
      thumbnailUrl: 'https://example.com/thumb.jpg',
      category: 'test',
    );

    final tNow = DateTime(2024, 1, 1, 12);

    final tHomeEntity = HomeEntity(
      id: '1',
      title: 'Test Home',
      subtitle: 'Test Subtitle',
      imageUrl: 'https://example.com/image.jpg',
      items: const [tHomeItemEntity],
      totalCount: 1,
      lastUpdated: tNow,
    );

    test('equality based on props', () {
      final home1 = HomeEntity(
        id: '1',
        title: 'Home 1',
        items: const [],
        totalCount: 0,
        lastUpdated: tNow,
      );
      final home2 = HomeEntity(
        id: '1',
        title: 'Home 1',
        items: const [],
        totalCount: 0,
        lastUpdated: tNow,
      );

      expect(home1, home2);
    });

    test('inequality when ids differ', () {
      final home1 = HomeEntity(
        id: '1',
        title: 'Home',
        items: const [],
        totalCount: 0,
        lastUpdated: tNow,
      );
      final home2 = HomeEntity(
        id: '2',
        title: 'Home',
        items: const [],
        totalCount: 0,
        lastUpdated: tNow,
      );

      expect(home1, isNot(home2));
    });

    test('copyWith returns new instance with updated values', () {
      final updated = tHomeEntity.copyWith(
        title: 'Updated Title',
        totalCount: 5,
      );

      expect(updated.id, tHomeEntity.id);
      expect(updated.title, 'Updated Title');
      expect(updated.totalCount, 5);
      expect(updated.subtitle, tHomeEntity.subtitle);
    });

    test('copyWith with null values keeps original', () {
      final updated = tHomeEntity.copyWith();

      expect(updated, tHomeEntity);
    });

    test('toJson produces correct map', () {
      final json = tHomeEntity.toJson();

      expect(json['id'], '1');
      expect(json['title'], 'Test Home');
      expect(json['subtitle'], 'Test Subtitle');
      expect(json['imageUrl'], 'https://example.com/image.jpg');
      expect(json['totalCount'], 1);
      expect(json['isCached'], false);
      expect(json['items'], isA<List<dynamic>>());
    });

    test('fromJson creates correct entity', () {
      final json = <String, dynamic>{
        'id': '1',
        'title': 'Test Home',
        'subtitle': 'Test Subtitle',
        'imageUrl': 'https://example.com/image.jpg',
        'items': [
          <String, dynamic>{
            'id': '1',
            'title': 'Test Item',
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

      final entity = HomeEntity.fromJson(json);

      expect(entity.id, '1');
      expect(entity.title, 'Test Home');
      expect(entity.subtitle, 'Test Subtitle');
      expect(entity.totalCount, 1);
      expect(entity.items.length, 1);
    });

    test('toString returns formatted string', () {
      expect(tHomeEntity.toString(), contains('HomeEntity'));
      expect(tHomeEntity.toString(), contains('id: 1'));
      expect(tHomeEntity.toString(), contains('title: Test Home'));
    });

    test('hashCode is consistent for equal objects', () {
      final home1 = HomeEntity(
        id: '1',
        title: 'Home',
        items: const [],
        totalCount: 0,
        lastUpdated: tNow,
      );
      final home2 = HomeEntity(
        id: '1',
        title: 'Home',
        items: const [],
        totalCount: 0,
        lastUpdated: tNow,
      );

      expect(home1.hashCode, home2.hashCode);
    });
  });

  group('HomeItemEntity', () {
    test('equality based on props', () {
      const item1 = HomeItemEntity(id: '1', title: 'Item 1', rank: 1);
      const item2 = HomeItemEntity(id: '1', title: 'Item 1', rank: 1);

      expect(item1, item2);
    });

    test('copyWith returns new instance with updated values', () {
      const item = HomeItemEntity(
        id: '1',
        title: 'Item 1',
        rank: 1,
        description: 'Original',
      );

      final updated = item.copyWith(description: 'Updated');

      expect(updated.id, item.id);
      expect(updated.description, 'Updated');
      expect(updated.title, item.title);
    });

    test('toJson produces correct map', () {
      const item = HomeItemEntity(
        id: '1',
        title: 'Item 1',
        rank: 1,
        description: 'Test',
      );

      final json = item.toJson();

      expect(json['id'], '1');
      expect(json['title'], 'Item 1');
      expect(json['rank'], 1);
      expect(json['description'], 'Test');
    });

    test('fromJson creates correct entity', () {
      final json = {
        'id': '1',
        'title': 'Item 1',
        'rank': 1,
        'description': 'Test',
        'thumbnailUrl': 'https://example.com/thumb.jpg',
        'category': 'test',
        'isFeatured': true,
      };

      final entity = HomeItemEntity.fromJson(json);

      expect(entity.id, '1');
      expect(entity.title, 'Item 1');
      expect(entity.rank, 1);
      expect(entity.isFeatured, true);
    });
  });
}
