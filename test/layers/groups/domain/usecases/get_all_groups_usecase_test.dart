import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_finances/layers/groups/domain/entities/group_entity.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_finances/layers/groups/domain/repositories/group_repository.dart';
import 'package:my_finances/layers/groups/domain/usecases/get_all_groups_usecase_imp.dart';

class GroupRepositoryMock extends Mock implements GroupRepository {}

void main() {
  late GroupRepositoryMock repository;
  late GetAllGroupsUseCaseImp usecase;
  final testGroup = [
    GroupEntity(
        id: '1',
        description: 'desc',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now()),
    GroupEntity(
        id: '1',
        description: 'desc',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now())
  ];
  setUpAll(() {
    // Registre o comportamento esperado para argumentos não nulos
    registerFallbackValue('');
  });
  setUp(() {
    repository = GroupRepositoryMock();
    usecase = GetAllGroupsUseCaseImp(repository);
  });
  group('group get all usecase tests', () {
    test('should return all groups', () async {
      when(() => repository.findAll()).thenAnswer(
        (_) async => Right(testGroup),
      );
      final result = await usecase();

      expect(result, isA<Right>());
      expect(result, Right(testGroup));
    });
  });
}
