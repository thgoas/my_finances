import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_finances/layers/groups/domain/entities/group_entity.dart';
import 'package:my_finances/layers/groups/domain/errors/failure_group.dart';
import 'package:my_finances/layers/groups/domain/repositories/get_all_groups_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_finances/layers/groups/domain/usecases/get_all_groups_usecase_imp.dart';

class GetAllGroupsRepositoryMock extends Mock
    implements GetAllGroupsRepository {}

void main() {
  late GetAllGroupsRepositoryMock repository;
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
    repository = GetAllGroupsRepositoryMock();
    usecase = GetAllGroupsUseCaseImp(repository);
  });
  group('group usecase tests', () {
    test('should return a group when the id is valid', () async {
      when(() => repository()).thenAnswer(
        (_) async => Right(testGroup),
      );
      final result = await usecase();

      expect(result, isA<Right>());
      expect(result, Right(testGroup));
    });
  });
}
