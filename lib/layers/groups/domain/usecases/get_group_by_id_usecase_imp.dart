import 'package:dartz/dartz.dart';
import 'package:my_finances/layers/groups/domain/entities/group_entity.dart';
import 'package:my_finances/layers/groups/domain/errors/failure_group.dart';
import 'package:my_finances/layers/groups/domain/repositories/get_groups_by_id_repository.dart';
import 'package:my_finances/layers/groups/domain/usecases/get_group_by_id_usecase.dart';

class GetGroupByIdUseCaseImp implements GetGroupByIdUseCase {
  final GetGroupsByIdRepository _repository;

  GetGroupByIdUseCaseImp(this._repository);
  @override
  Future<Either<FailureGroup, GroupEntity>> call(String id) async {
    if (id.isEmpty) {
      return Left(InvalidIdError('Invalid id'));
    }
    return _repository(id);
  }
}
