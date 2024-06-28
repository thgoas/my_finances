// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:my_finances/layers/groups/domain/entities/group_entity.dart';
import 'package:my_finances/layers/groups/domain/errors/failure_group.dart';
import 'package:my_finances/layers/groups/domain/repositories/delete_group_repository.dart';
import 'package:my_finances/layers/groups/domain/usecases/delete_group_usecase.dart';

class DeleteGroupUseCaseImp implements DeleteGroupUseCase {
  final DeleteGroupRepository _repository;
  DeleteGroupUseCaseImp(
    this._repository,
  );
  @override
  Future<Either<FailureGroup, GroupEntity>> call(String id) async {
    if (id.isEmpty) {
      return Left(InvalidIdError('Id can not empty'));
    }
    return _repository(id);
  }
}
