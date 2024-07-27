import 'package:dartz/dartz.dart';
import 'package:my_finances/layers/groups/domain/entities/group_entity.dart';
import 'package:my_finances/layers/groups/domain/errors/failure_group.dart';
import 'package:my_finances/layers/groups/domain/repositories/group_repository.dart';
import 'package:my_finances/layers/groups/domain/usecases/update_group_usecase.dart';

class UpdateGroupUseCaseImp implements UpdateGroupUseCase {
  final GroupRepository _repository;

  UpdateGroupUseCaseImp(this._repository);
  @override
  Future<Either<FailureGroup, GroupEntity>> call(
      String id, String description) async {
    if (id.isEmpty) {
      return Left(InvalidIdError('Id can not empty'));
    } else if (description.isEmpty) {
      return Left(InvalidDescriptionError('description can not empty'));
    }
    final group = GroupEntity(
        id: id,
        description: description,
        createdAt: null,
        updatedAt: DateTime.now());

    return _repository.update(id, group);
  }
}
