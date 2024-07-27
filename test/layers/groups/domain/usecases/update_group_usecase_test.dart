import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_finances/layers/groups/domain/entities/group_entity.dart';
import 'package:my_finances/layers/groups/domain/errors/failure_group.dart';
import 'package:my_finances/layers/groups/domain/repositories/group_repository.dart';
import 'package:my_finances/layers/groups/domain/usecases/update_group_usecase.dart';
import 'package:my_finances/layers/groups/domain/usecases/update_group_usecase_imp.dart';

class GroupRepositoryMock extends Mock implements GroupRepository {}

main() {
  late GroupRepositoryMock repository;
  late UpdateGroupUseCase usecase;
  final testGroup = GroupEntity(
      id: '1',
      description: 'desc edit',
      createdAt: null,
      updatedAt: DateTime.now());

  setUpAll(() {
    registerFallbackValue(testGroup);
  });
  setUp(() {
    repository = GroupRepositoryMock();
    usecase = UpdateGroupUseCaseImp(repository);
  });

  group('Update group use case', () {
    test('should return group edited with success', () async {
      const idInput = '1';
      const description = 'desc edit';

      when(() => repository.update(any(), any()))
          .thenAnswer((_) async => Right(testGroup));

      final result = await usecase(idInput, description);

      expect(result, isA<Right>());
      expect(result, Right(testGroup));
    });
    test('should return exception with id is empty', () async {
      final idInput = '';
      final description = 'desc edit';
      when(() => repository.update(any(), any()))
          .thenAnswer((_) async => Right(testGroup));
      final result = await usecase(idInput, description);
      expect(result, isA<Left>());
      expect(result.fold(id, id), isA<InvalidIdError>());
    });

    test('should return exception with description is empty', () async {
      final idInput = '1';
      final description = '';
      when(() => repository.update(any(), any()))
          .thenAnswer((_) async => Right(testGroup));
      final result = await usecase(idInput, description);

      expect(result, isA<Left>());
      expect(result.fold(id, id), isA<InvalidDescriptionError>());
    });
  });
}
