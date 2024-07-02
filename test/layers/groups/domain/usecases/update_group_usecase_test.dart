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
      createdAt: DateTime.now(),
      updatedAt: DateTime.now());

  setUpAll(() {
    // Registre o comportamento esperado para argumentos não nulos
    registerFallbackValue('');
  });
  setUp(() {
    repository = GroupRepositoryMock();
    usecase = UpdateGroupUseCaseImp(repository);
  });

  group('Update group use case', () {
    test('should return group edited with success', () async {
      final id = '1';
      final groupEdit =
          GroupEntityInput(description: 'desc edit', updatedAt: DateTime.now());
      when(() => repository.update(id, groupEdit))
          .thenAnswer((_) async => Right(testGroup));
      final result = await usecase(id, groupEdit);

      expect(result, isA<Right>());
      expect(result, Right(testGroup));
    });
    test('should return exception with id is empty', () async {
      final idInput = '';
      final groupEdit =
          GroupEntityInput(description: 'desc edit', updatedAt: DateTime.now());
      when(() => repository.update(idInput, groupEdit))
          .thenAnswer((_) async => Right(testGroup));
      final result = await usecase(idInput, groupEdit);

      expect(result, isA<Left>());
      expect(result.fold(id, id), isA<InvalidIdError>());
    });

    test('should return exception with description is empty', () async {
      final idInput = '1';
      final groupEdit =
          GroupEntityInput(description: '', updatedAt: DateTime.now());
      when(() => repository.update(idInput, groupEdit))
          .thenAnswer((_) async => Right(testGroup));
      final result = await usecase(idInput, groupEdit);

      expect(result, isA<Left>());
      expect(result.fold(id, id), isA<InvalidDescriptionError>());
    });
  });
}
