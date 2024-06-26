import 'package:dartz/dartz.dart';
import 'package:my_finances/layers/groups/domain/errors/failure_group.dart';
import 'package:my_finances/layers/groups/domain/usecases/update_group_usecase.dart';
import '../entities/group_entity.dart';

abstract class UpdateGroupRepository {
  Future<Either<FailureGroup, GroupEntity>> call(
      String id, GroupEntityInput groupEntity);
}
