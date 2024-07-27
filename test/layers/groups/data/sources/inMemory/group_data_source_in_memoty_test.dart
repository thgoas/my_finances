import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_finances/layers/groups/data/errors/group_data_source_erros.dart';
import 'package:my_finances/layers/groups/data/repositories/group_repository_imp.dart';
import 'package:my_finances/layers/groups/data/sources/inMemory/group_data_source_in_memory.dart';
import 'package:my_finances/layers/groups/domain/errors/failure_group.dart';
import 'package:my_finances/layers/groups/domain/usecases/delete_group_usecase_imp.dart';
import 'package:my_finances/layers/groups/domain/usecases/get_all_groups_usecase_imp.dart';
import 'package:my_finances/layers/groups/domain/usecases/get_group_by_description_usecase_imp.dart';
import 'package:my_finances/layers/groups/domain/usecases/get_group_by_id_usecase_imp.dart';
import 'package:my_finances/layers/groups/domain/usecases/new_group_usecase_imp.dart';
import 'package:my_finances/layers/groups/domain/usecases/update_group_usecase_imp.dart';

main() {
  final dataSource = GroupDataSourceInMemory();
  final repository = GroupRepositoryImp(dataSource);
  final getUsecase = GetAllGroupsUseCaseImp(repository);
  final getGroupByIdUsecase = GetGroupByIdUseCaseImp(repository);
  final getGroupByDescriptionUsecase =
      GetGroupByDescriptionUseCaseImp(repository);
  final deleteGroupUsecase = DeleteGroupUseCaseImp(repository);
  final newGroupUsecase = NewGroupUseCaseImp(repository);
  final updateGroupUsecase = UpdateGroupUseCaseImp(repository);
  group('Data Source In Memory tests', () {
    test('should return all groups', () async {
      final result = await getUsecase();
      expect(result, isA<Right>());
      expect(result.fold((l) => null, (r) => r.length), 3);
    });

    test('should return first group by id', () async {
      final result = await getGroupByIdUsecase('1');
      expect(result, isA<Right>());
      expect(result.fold((l) => null, (r) => r.description), 'group 1');
    });

    test('should return a exception if id is empty', () async {
      final result = await getGroupByIdUsecase('');
      expect(result, isA<Left>());
      expect(result.fold(id, id), isA<InvalidIdError>());
      expect(
          result.fold(
            (l) => l.message,
            (r) => null,
          ),
          'Invalid id');
    });

    test('should return a exception if id is not exist', () async {
      final result = await getGroupByIdUsecase('100');
      expect(result, isA<Left>());
      expect(result.fold(id, id), isA<NoElementDataSourceError>());
      expect(
          result.fold(
            (l) => l.message,
            (r) => null,
          ),
          'No data found');
    });

    test('should return first group by description', () async {
      final result = await getGroupByDescriptionUsecase('group 1');
      expect(result, isA<Right>());
      expect(result.fold((l) => null, (r) => r.description), 'group 1');
    });

    test('should return a exception if description is empty', () async {
      final result = await getGroupByDescriptionUsecase('');
      expect(result, isA<Left>());
      expect(result.fold(id, id), isA<InvalidDescriptionError>());
      expect(
          result.fold(
            (l) => l.message,
            (r) => null,
          ),
          'Invalid Description');
    });

    test('should return a exception if description is not exist', () async {
      final result = await getGroupByDescriptionUsecase('100');
      expect(result, isA<Left>());
      expect(result.fold(id, id), isA<NoElementDataSourceError>());
      expect(
          result.fold(
            (l) => l.message,
            (r) => null,
          ),
          'No data found');
    });

    test('should delete group', () async {
      final result = await deleteGroupUsecase('1');
      expect(result, isA<Right>());
      expect(result.fold((l) => null, (r) => r.description), 'group 1');
    });

    test('should return 2 groups', () async {
      final result = await getUsecase();
      expect(result, isA<Right>());
      expect(result.fold((l) => null, (r) => r.length), 2);
    });

    test('should return a exception when delete group if id empty', () async {
      final result = await deleteGroupUsecase('');
      expect(result.fold(id, id), isA<InvalidIdError>());
      expect(
          result.fold(
            (l) => l.message,
            (r) => null,
          ),
          'Id can not empty');
    });

    test('should return a exception when delete group if id not exist',
        () async {
      final result = await deleteGroupUsecase('100');
      expect(result, isA<Left>());
      expect(result.fold(id, id), isA<NoElementDataSourceError>());
      expect(
          result.fold(
            (l) => l.message,
            (r) => null,
          ),
          'No data found');
    });

    test('should return a new group', () async {
      final result = await newGroupUsecase('new group');
      expect(result, isA<Right>());
      expect(result.fold((l) => null, (r) => r.description), 'new group');
    });

    test('should return 3 groups', () async {
      final result = await getUsecase();
      expect(result, isA<Right>());
      expect(result.fold((l) => null, (r) => r.length), 3);
    });

    test('should return a group edited', () async {
      final result = await updateGroupUsecase('2', 'group 2 edited');

      expect(result, isA<Right>());
      expect(result.fold((l) => null, (r) => r.description), 'group 2 edited');
    });
    test('should return a exception when update group if id empty', () async {
      final result = await updateGroupUsecase('', 'group 2 edited');
      expect(result.fold(id, id), isA<InvalidIdError>());
      expect(
          result.fold(
            (l) => l.message,
            (r) => null,
          ),
          'Id can not empty');
    });
    test('should return a exception when update group if id not exist',
        () async {
      final result = await updateGroupUsecase('100', 'group 2 edited');
      expect(result.fold(id, id), isA<NoElementDataSourceError>());
      expect(
          result.fold(
            (l) => l.message,
            (r) => null,
          ),
          'No data found');
    });
  });
}
