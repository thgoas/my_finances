import 'package:dartz/dartz.dart';
import 'package:my_finances/layers/groups/domain/entities/group_entity.dart';
import 'package:my_finances/layers/groups/domain/errors/failure_group.dart';
import 'package:my_finances/layers/groups/domain/repositories/group_repository.dart';
import 'package:my_finances/layers/groups/domain/usecases/new_group_usecase.dart';
import 'package:uuid/uuid.dart';

class NewGroupUseCaseImp implements NewGroupUseCase {
  final GroupRepository _repository;

  NewGroupUseCaseImp(this._repository);

  @override
  Future<Either<FailureGroup, GroupEntity>> call(String description) async {
    if (description.isEmpty) {
      return Left(InvalidFieldsError('description can not Empty'));
    }
    const groupId = Uuid();
    final group = GroupEntity(
        id: groupId.v4(),
        description: description,
        createdAt: DateTime.now(),
        updatedAt: null);

    final result = await _repository.save(group);
    return result;
  }
}
