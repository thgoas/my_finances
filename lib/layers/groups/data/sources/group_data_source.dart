import 'package:my_finances/layers/groups/data/dtos/group_dto.dart';
import 'package:my_finances/layers/groups/domain/entities/group_entity.dart';
import 'package:my_finances/layers/groups/domain/usecases/update_group_usecase.dart';

abstract class GroupDataSource {
  Future<GroupDto> save(GroupEntity groupEntity);
  Future<GroupDto?> update(String id, GroupEntity groupEntity);
  Future<GroupDto?> findById(String id);
  Future<GroupDto?> findByDescription(String description);
  Future<List<GroupDto>> findAll();
  Future<void> remove(String id);
}
