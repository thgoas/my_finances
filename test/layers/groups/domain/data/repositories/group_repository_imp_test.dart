import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_finances/layers/groups/data/dtos/group_dto.dart';
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
    // Registre o comportamento esperado para argumentos não nulos
    registerFallbackValue('');
  });
  setUp(() {
    groupDataSource = GroupDataSourceMock();
    repository = GroupRepositoryImp(groupDataSource);
  });
  group('group repository', () {
    test('should return all groups', () async {
      when(() => groupDataSource.findAll())
          .thenAnswer((_) async => resultGroup);
      final result = await repository.findAll();

      expect(result, isA<Right>());
      expect(result, Right(resultGroup));
    });
  });
}
