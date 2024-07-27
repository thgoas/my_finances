import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_finances/layers/groups/domain/entities/group_entity.dart';
import 'package:my_finances/layers/groups/domain/errors/failure_group.dart';
import 'package:my_finances/layers/groups/domain/repositories/group_repository.dart';
import 'package:my_finances/layers/groups/domain/usecases/delete_group_usecase.dart';
import 'package:my_finances/layers/groups/domain/usecases/delete_group_usecase_imp.dart';

class GroupRepositoryMock extends Mock implements GroupRepository {}

main() {
  late GroupRepositoryMock repository;
  late DeleteGroupUseCase usecase;
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
    usecase = DeleteGroupUseCaseImp(repository);
  });

  group('Delete group use case', () {
    test('should return success when delete group', () async {
      final id = '1';

      when(() => repository.remove(id))
          .thenAnswer((_) async => Right(testGroup));
      final result = await usecase(id);

      expect(result, isA<Right>());
      expect(result, Right(testGroup));
    });
    test('should return exception with id is empty', () async {
      final idInput = '';

      when(() => repository.remove(idInput))
          .thenAnswer((_) async => Right(testGroup));
      final result = await usecase(idInput);

      expect(result, isA<Left>());
      expect(result.fold(id, id), isA<InvalidIdError>());
    });
  });
}
