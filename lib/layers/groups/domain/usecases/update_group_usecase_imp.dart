import 'package:dartz/dartz.dart';
import 'package:my_finances/layers/groups/domain/entities/group_entity.dart';
import 'package:my_finances/layers/groups/domain/errors/failure_group.dart';
import 'package:my_finances/layers/groups/domain/repositories/update_group_repository.dart';
import 'package:my_finances/layers/groups/domain/usecases/update_group_usecase.dart';

class UpdateGroupUseCaseImp implements UpdateGroupUseCase {
  final UpdateGroupRepository _repository;

  UpdateGroupUseCaseImp(this._repository);
  @override
  Future<Either<FailureGroup, GroupEntity>> call(
      String id, GroupEntityInput groupEntity) async {
    if (id.isEmpty) {
      return Left(InvalidIdError('id can not empty'));
    } else if (groupEntity.description.isEmpty) {
      return Left(InvalidDescriptionError('description can not empty'));
    }

    return _repository(id, groupEntity);
  }
}
