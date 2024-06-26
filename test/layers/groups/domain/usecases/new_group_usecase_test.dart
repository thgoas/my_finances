import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_finances/layers/groups/domain/entities/group_entity.dart';
import 'package:my_finances/layers/groups/domain/errors/failure_group.dart';
import 'package:my_finances/layers/groups/domain/repositories/new_group_repository.dart';
import 'package:my_finances/layers/groups/domain/usecases/new_group_usecase.dart';
import 'package:my_finances/layers/groups/domain/usecases/new_group_usecase_imp.dart';

class NewGroupRepositoryMock extends Mock implements NewGroupRepository {}

void main() {
  late NewGroupRepositoryMock repository;
  late NewGroupUseCase usecase;
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
    repository = NewGroupRepositoryMock();
    usecase = NewGroupUseCaseImp(repository);
  });
  group('create a new group tests', () {
    test('should create a new group and returned', () async {
      final newGroup = GroupEntity(
          id: '1',
          description: 'desc',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now());
      when(() => repository(newGroup)).thenAnswer(
        (_) async => Right(testGroup),
      );
      final result = await usecase(newGroup);

      expect(result, isA<Right>());
      expect(result, Right(testGroup));
    });

    test('should return Failure when id is empty', () async {
      final newGroup = GroupEntity(
          id: '',
          description: 'desc',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now());
      when(() => repository(newGroup))
          .thenAnswer((_) async => Right(testGroup));
      final result = await usecase(newGroup);
      expect(result, isA<Left>());
      expect(result.fold(id, id), isA<InvalidFieldsError>());
    });

    test('should return Failure when description is empty', () async {
      final newGroup = GroupEntity(
          id: '1',
          description: '',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now());
      when(() => repository(newGroup))
          .thenAnswer((_) async => Right(testGroup));
      final result = await usecase(newGroup);
      expect(result, isA<Left>());
      expect(result.fold(id, id), isA<InvalidFieldsError>());
    });
  });
}
