import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_finances/layers/groups/domain/entities/group_entity.dart';
import 'package:my_finances/layers/groups/domain/errors/failure_group.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_finances/layers/groups/domain/repositories/group_repository.dart';
import 'package:my_finances/layers/groups/domain/usecases/get_group_by_description_usecase_imp.dart';

class GroupRepositoryMock extends Mock implements GroupRepository {}

void main() {
  late GroupRepositoryMock repository;
  late GetGroupByDescriptionUseCaseImp usecase;
  final testGroup = GroupEntity(
      id: '1',
      description: 'desc',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now());

  setUpAll(() {
    // Registre o comportamento esperado para argumentos não nulos
    registerFallbackValue('');
  });
  setUp(() {
    repository = GroupRepositoryMock();
    usecase = GetGroupByDescriptionUseCaseImp(repository);
  });
  group('group get by description usecase tests', () {
    test('should return a group when the desc is valid', () async {
      when(() => repository.findByDescription(any())).thenAnswer(
        (_) async => Right(testGroup),
      );
      final result = await usecase('desc');

      expect(result, isA<Right>());
      expect(result, Right(testGroup));
    });
    test('should return a failureGroup when there is a failure', () async {
      when(() => repository.findById(any())).thenAnswer(
        (_) async => Left(InvalidDescriptionError('Invalid error')),
      );
      final result = await usecase('');
      expect(result, isA<Left>());
      expect(result.fold(id, id), isA<InvalidDescriptionError>());
    });
  });
}
