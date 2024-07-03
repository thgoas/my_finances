import 'package:dartz/dartz.dart';
import 'package:my_finances/layers/groups/data/erros/group_data_source_erros.dart';
import 'package:my_finances/layers/groups/data/sources/group_data_source.dart';
import 'package:my_finances/layers/groups/domain/entities/group_entity.dart';
import 'package:my_finances/layers/groups/domain/errors/failure_group.dart';
import 'package:my_finances/layers/groups/domain/repositories/group_repository.dart';
import 'package:my_finances/layers/groups/domain/usecases/update_group_usecase.dart';

class GroupRepositoryImp implements GroupRepository {
  final GroupDataSource groupDataSource;
  GroupRepositoryImp(this.groupDataSource);
  @override
  Future<Either<FailureGroup, List<GroupEntity>>> findAll() async {
    try {
      final result = await groupDataSource.findAll();
      if (result.isEmpty) {
        return Left(NoElementDataSourceError('No data found'));
      }
      return Right(result);
    } catch (e) {
      return Left(DataSourceException(e.toString()));
    }
  }

  @override
  Future<Either<FailureGroup, GroupEntity>> findByDescription(
      String description) {
    // TODO: implement findByDescription
    throw UnimplementedError();
  }

  @override
  Future<Either<FailureGroup, GroupEntity>> findById(String id) {
    // TODO: implement findById
    throw UnimplementedError();
  }

  @override
  Future<Either<FailureGroup, GroupEntity>> remove(String id) {
    // TODO: implement remove
    throw UnimplementedError();
  }

  @override
  Future<Either<FailureGroup, GroupEntity>> save(GroupEntity groupEntity) {
    // TODO: implement save
    throw UnimplementedError();
  }

  @override
  Future<Either<FailureGroup, GroupEntity>> update(
      String id, GroupEntityInput groupEntity) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
