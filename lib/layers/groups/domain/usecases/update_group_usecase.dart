import 'package:dartz/dartz.dart';
import 'package:my_finances/layers/groups/domain/entities/group_entity.dart';
import 'package:my_finances/layers/groups/domain/errors/failure_group.dart';

abstract class UpdateGroupUseCase {
  Future<Either<FailureGroup, GroupEntity>> call(
      String id, GroupEntityInput groupEntity);
}

class GroupEntityInput {
  final String description;
  final DateTime updatedAt;

  GroupEntityInput({required this.description, required this.updatedAt});
}
