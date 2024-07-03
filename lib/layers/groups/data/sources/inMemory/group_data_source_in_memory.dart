import 'package:my_finances/layers/groups/data/dtos/group_dto.dart';
import 'package:my_finances/layers/groups/data/sources/group_data_source.dart';
import 'package:my_finances/layers/groups/domain/entities/group_entity.dart';
import 'package:my_finances/layers/groups/domain/usecases/update_group_usecase.dart';

class GroupDataSourceInMemory implements GroupDataSource {
  @override
  Future<List<GroupDto>> findAll() async {
    return groups.map((groupMap) => GroupDto.fromMap(groupMap)).toList();
  }

  @override
  Future<GroupDto?> findByDescription(String description) {
    // TODO: implement findByDescription
    throw UnimplementedError();
  }

  @override
  Future<GroupDto?> findById(String id) {
    // TODO: implement findById
    throw UnimplementedError();
  }

  @override
  Future<GroupDto> remove(String id) {
    // TODO: implement remove
    throw UnimplementedError();
  }

  @override
  Future<GroupDto> save(GroupEntity groupDto) {
    // TODO: implement save
    throw UnimplementedError();
  }

  @override
  Future<GroupDto> update(String id, GroupEntityInput groupDto) {
    // TODO: implement update
    throw UnimplementedError();
  }
}

final groups = [
  {
    "id": "1",
    "description": "group 1",
    "createAt": "2023-01-01",
    "updatedAt": ""
  },
  {
    "id": "2",
    "description": "group 2",
    "createAt": "2023-01-01",
    "updatedAt": ""
  },
  {
    "id": "3",
    "description": "group 3",
    "createAt": "2023-01-01",
    "updatedAt": ""
  },
] as List<Map<String, dynamic>>;
