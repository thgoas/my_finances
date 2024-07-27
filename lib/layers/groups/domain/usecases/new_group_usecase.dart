import 'package:dartz/dartz.dart';
import 'package:my_finances/layers/groups/domain/entities/group_entity.dart';
import 'package:my_finances/layers/groups/domain/errors/failure_group.dart';

abstract class NewGroupUseCase {
  Future<Either<FailureGroup, GroupEntity>> call(String description);
}
