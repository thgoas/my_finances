import 'package:dartz/dartz.dart';
import 'package:my_finances/layers/groups/domain/entities/group_entity.dart';
import 'package:my_finances/layers/groups/domain/errors/failure_group.dart';
import 'package:my_finances/layers/groups/domain/repositories/get_all_groups_repository.dart';
import 'package:my_finances/layers/groups/domain/usecases/get_all_groups_usecase.dart';

class GetAllGroupsUseCaseImp implements GetAllGroupsUseCase {
  final GetAllGroupsRepository _repository;

  GetAllGroupsUseCaseImp(this._repository);

  @override
  Future<Either<FailureGroup, List<GroupEntity>>> call() async {
    return _repository();
  }
}
