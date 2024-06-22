import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_finances/layers/groups/domain/entities/group_entity.dart';
import 'package:my_finances/layers/groups/domain/errors/failure_group.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_finances/layers/groups/domain/repositories/get_groups_by_id_repository.dart';
import 'package:my_finances/layers/groups/domain/usecases/get_group_by_id_usecase_imp.dart';

class GetGroupByIdRepositoryMock extends Mock
    implements GetGroupsByIdRepository {}

void main() {
  late GetGroupByIdRepositoryMock repository;
  late GetGroupByIdUseCaseImp usecase;
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
    repository = GetGroupByIdRepositoryMock();
    usecase = GetGroupByIdUseCaseImp(repository);
  });
  group('group usecase tests', () {
    test('should return a group when the id is valid', () async {
      when(() => repository(any())).thenAnswer(
        (_) async => Right(testGroup),
      );
      final result = await usecase('1');

      expect(result, isA<Right>());
      expect(result, Right(testGroup));
    });
    test('should return a failureGroup when there is a failure', () async {
      when(() => repository(any())).thenAnswer(
        (_) async => Left(InvalidIdError('Invalid error')),
      );
      final result = await usecase('');
      expect(result, isA<Left>());
      expect(result.fold(id, id), isA<InvalidIdError>());
    });
  });
}
