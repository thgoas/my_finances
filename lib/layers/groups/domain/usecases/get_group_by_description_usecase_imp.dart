import 'package:dartz/dartz.dart';
import 'package:my_finances/layers/groups/domain/entities/group_entity.dart';
import 'package:my_finances/layers/groups/domain/errors/failure_group.dart';
import 'package:my_finances/layers/groups/domain/repositories/get_groups_by_description_repository.dart';
import 'package:my_finances/layers/groups/domain/usecases/get_group_by_description_usecase.dart';

class GetGroupByDescriptionUseCaseImp implements GetGroupByDescriptionUseCase {
  final GetGroupsByDescriptionRepository _repository;

  GetGroupByDescriptionUseCaseImp(this._repository);
  @override
  Future<Either<FailureGroup, GroupEntity>> call(String description) async {
    if (description.isEmpty) {
      return Left(InvalidDescriptionError('Invalid Description'));
    }
    return _repository(description);
  }
}
