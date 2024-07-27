import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_finances/layers/groups/domain/entities/group_entity.dart';
import 'package:my_finances/layers/groups/domain/errors/failure_group.dart';
import 'package:my_finances/layers/groups/domain/repositories/group_repository.dart';
import 'package:my_finances/layers/groups/domain/usecases/new_group_usecase.dart';
import 'package:my_finances/layers/groups/domain/usecases/new_group_usecase_imp.dart';

class GroupRepositoryMock extends Mock implements GroupRepository {}

void main() {
  late GroupRepositoryMock repository;
  late NewGroupUseCase usecase;
  final testGroup = GroupEntity(
      id: '1', description: 'desc', createdAt: DateTime.now(), updatedAt: null);

  setUpAll(() {
    // Registre o comportamento esperado para argumentos não nulos
    registerFallbackValue(testGroup);
  });
  setUp(() {
    repository = GroupRepositoryMock();
    usecase = NewGroupUseCaseImp(repository);
  });
  group('create a new group tests', () {
    test('should create a new group and returned', () async {
      const description = 'desc';
      when(() => repository.save(any())).thenAnswer(
        (_) async => Right(testGroup),
      );

      final result = await usecase(description);

      expect(result, isA<Right>());
      expect(result, Right(testGroup));
    });

    test('should return Failure when description is empty', () async {
      const description = '';
      when(() => repository.save(testGroup))
          .thenAnswer((_) async => Right(testGroup));
      final result = await usecase(description);
      expect(result, isA<Left>());
      expect(result.fold(id, id), isA<InvalidFieldsError>());
    });
  });
}
