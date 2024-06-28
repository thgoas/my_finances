import 'package:dartz/dartz.dart';
import 'package:my_finances/layers/groups/domain/entities/group_entity.dart';
import 'package:my_finances/layers/groups/domain/errors/failure_group.dart';
import 'package:my_finances/layers/groups/domain/repositories/new_group_repository.dart';

class NewGroupRepositoryImp implements NewGroupRepository {
  @override
  Future<Either<FailureGroup, GroupEntity>> call(
      GroupEntity groupEntity) async {
    return Right(groupEntity);
  }
}
