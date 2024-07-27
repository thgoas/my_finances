import 'package:dartz/dartz.dart';
import 'package:my_finances/layers/groups/domain/entities/group_entity.dart';
import 'package:my_finances/layers/groups/domain/errors/failure_group.dart';
import 'package:my_finances/layers/groups/domain/usecases/update_group_usecase.dart';

abstract class GroupRepository {
  Future<Either<FailureGroup, GroupEntity>> save(GroupEntity groupEntity);
  Future<Either<FailureGroup, GroupEntity>> update(
      String id, GroupEntity groupEntity);
  Future<Either<FailureGroup, GroupEntity>> findById(String id);
  Future<Either<FailureGroup, GroupEntity>> findByDescription(
      String description);
  Future<Either<FailureGroup, List<GroupEntity>>> findAll();
  Future<Either<FailureGroup, GroupEntity>> remove(String id);
}
