import 'package:my_finances/layers/groups/data/dtos/group_dto.dart';

abstract class GroupDataSource {
  Future<GroupDto> save(GroupDto groupDto);
  Future<GroupDto> update(String id, GroupDto groupDto);
  Future<GroupDto?> findById(String id);
  Future<GroupDto?> findByDescription(String description);
  Future<List<GroupDto>> findAll();
  Future<GroupDto> remove(String id);
}
