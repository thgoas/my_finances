import 'package:dartz/dartz.dart';
import 'package:my_finances/layers/groups/data/dtos/group_dto.dart';
import 'package:my_finances/layers/groups/data/errors/group_data_source_erros.dart';
import 'package:my_finances/layers/groups/data/sources/group_data_source.dart';
import 'package:my_finances/layers/groups/domain/entities/group_entity.dart';
import 'package:my_finances/layers/groups/domain/errors/failure_group.dart';
import 'package:my_finances/layers/groups/domain/repositories/group_repository.dart';
import 'package:my_finances/layers/groups/domain/usecases/update_group_usecase.dart';

class GroupRepositoryImp implements GroupRepository {
  final GroupDataSource _groupDataSource;
  GroupRepositoryImp(this._groupDataSource);
  @override
  Future<Either<FailureGroup, List<GroupEntity>>> findAll() async {
    try {
      final result = await _groupDataSource.findAll();
      if (result.isEmpty) {
        return Left(NoElementDataSourceError('No data found'));
      }
      return Right(result);
    } catch (e) {
      print('repository ${e}');
      return Left(DataSourceException(e.toString()));
    }
  }

  @override
  Future<Either<FailureGroup, GroupEntity>> findByDescription(
      String description) async {
    try {
      final result = await _groupDataSource.findByDescription(description);

      if (result == null) {
        return Left(NoElementDataSourceError('No data found'));
      }

      return Right(result);
    } catch (e) {
      return Left(DataSourceException(e.toString()));
    }
  }

  @override
  Future<Either<FailureGroup, GroupEntity>> findById(String id) async {
    try {
      final result = await _groupDataSource.findById(id);

      if (result == null) {
        return Left(NoElementDataSourceError('No data found'));
      }

      return Right(result);
    } catch (e) {
      return Left(DataSourceException(e.toString()));
    }
  }

  @override
  Future<Either<FailureGroup, GroupEntity>> remove(String id) async {
    try {
      final group = await _groupDataSource.findById(id);

      if (group == null) {
        return Left(NoElementDataSourceError('No data found'));
      }
      await _groupDataSource.remove(id);

      return Right(group);
    } catch (e) {
      return Left(DataSourceException(e.toString()));
    }
  }

  @override
  Future<Either<FailureGroup, GroupEntity>> save(
      GroupEntity groupEntity) async {
    try {
      final result = await _groupDataSource.save(groupEntity);

      return Right(result);
    } catch (e) {
      return Left(DataSourceException(e.toString()));
    }
  }

  @override
  Future<Either<FailureGroup, GroupEntity>> update(
      String id, GroupEntity groupEntity) async {
    try {
      final result = await _groupDataSource.update(id, groupEntity);
      if (result == null) {
        return Left(NoElementDataSourceError('No data found'));
      }
      return Right(result);
    } catch (e) {
      return Left(DataSourceException(e.toString()));
    }
  }
}
