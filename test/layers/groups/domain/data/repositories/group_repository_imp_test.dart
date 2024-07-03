import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_finances/layers/groups/data/dtos/group_dto.dart';
import 'package:my_finances/layers/groups/data/erros/group_data_source_erros.dart';
import 'package:my_finances/layers/groups/data/repositories/group_repository_imp.dart';
import 'package:my_finances/layers/groups/data/sources/group_data_source.dart';

class GroupDataSourceMock extends Mock implements GroupDataSource {}

main() {
  late GroupDataSourceMock groupDataSource;
  late GroupRepositoryImp repository;
  final resultGroup = [
    GroupDto(
        id: '1',
        description: 'description',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now())
  ];

  setUpAll(() {
    registerFallbackValue('');
  });
  setUp(() {
    groupDataSource = GroupDataSourceMock();
    repository = GroupRepositoryImp(groupDataSource);
  });
  group('find all group repository', () {
    test('should return all groups', () async {
      when(() => groupDataSource.findAll())
          .thenAnswer((_) async => resultGroup);
      final result = await repository.findAll();

      expect(result, isA<Right>());
      expect(result, Right(resultGroup));
    });
    test('should return a NoElementDataSourceError', () async {
      when(() => groupDataSource.findAll()).thenAnswer((_) async => []);
      final result = await repository.findAll();

      expect(result, isA<Left>());
      expect(result.fold(id, id), isA<NoElementDataSourceError>());
    });

    test('should return a DataSourceException', () async {
      when(() => groupDataSource.findAll())
          .thenThrow(Exception('Data source error'));
      final result = await repository.findAll();

      expect(result, isA<Left>());
      expect(result.fold(id, id), isA<DataSourceException>());
    });
  });

  group('find by ID group repository', () {
    test('should return a group by id', () async {
      when(() => groupDataSource.findById(any()))
          .thenAnswer((_) async => resultGroup[0]);
      final result = await repository.findById('1');

      expect(result, isA<Right>());
      expect(result, Right(resultGroup[0]));
    });
    test('should return NoElementDataSourceError', () async {
      when(() => groupDataSource.findById(any())).thenAnswer((_) async => null);
      final result = await repository.findById('1');

      expect(result, isA<Left>());
      expect(result.fold(id, id), isA<NoElementDataSourceError>());
    });

    test('should return DataSourceException', () async {
      when(() => groupDataSource.findById(any())).thenThrow(Exception());
      final result = await repository.findById('1');

      expect(result, isA<Left>());
      expect(result.fold(id, id), isA<DataSourceException>());
    });
  });
}
