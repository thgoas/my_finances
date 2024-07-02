import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_finances/layers/groups/data/repositories/new_group_repository_imp.dart';
import 'package:my_finances/layers/groups/domain/entities/group_entity.dart';

main() {
  // late GetOneGroupDataSourceMock getOneGroupDataSource;
  late GroupRepositoryImp repository;
  // final resultGroup = GroupDto(id: '1', description: 'desc', type: 'type');
  setUpAll(() {
    // Registre o comportamento esperado para argumentos não nulos
    registerFallbackValue('');
  });
  setUp(() {
    // getOneGroupDataSource = GetOneGroupDataSourceMock();
    repository = GroupRepositoryImp();
  });
  group('New group repository', () {
    test('should return a new group', () async {
      final newgroup = GroupEntity(
          id: '1',
          description: 'desc',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now());
      final result = await repository.save(newgroup);
      expect(result, isA<Right>());
      expect(result, Right(newgroup));
    });
  });
}
