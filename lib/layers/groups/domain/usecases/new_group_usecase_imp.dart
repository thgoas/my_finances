import 'package:dartz/dartz.dart';
import 'package:my_finances/layers/groups/domain/entities/group_entity.dart';
import 'package:my_finances/layers/groups/domain/errors/failure_group.dart';
import 'package:my_finances/layers/groups/domain/repositories/new_group_repository.dart';
import 'package:my_finances/layers/groups/domain/usecases/new_group_usecase.dart';

class NewGroupUseCaseImp implements NewGroupUseCase {
  final NewGroupRepository _repository;

  NewGroupUseCaseImp(this._repository);

  @override
  Future<Either<FailureGroup, GroupEntity>> call(
      GroupEntity groupEntity) async {
    if (groupEntity.id.isEmpty || groupEntity.description.isEmpty) {
      return Left(InvalidFieldsError('id and description can not Empty'));
    }
    return await _repository(groupEntity);
  }
}
