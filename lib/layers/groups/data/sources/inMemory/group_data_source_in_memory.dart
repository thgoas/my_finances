import 'package:my_finances/layers/groups/data/dtos/group_dto.dart';
import 'package:my_finances/layers/groups/data/errors/group_data_source_erros.dart';
import 'package:my_finances/layers/groups/data/sources/group_data_source.dart';
import 'package:my_finances/layers/groups/domain/entities/group_entity.dart';

class GroupDataSourceInMemory implements GroupDataSource {
  @override
  Future<List<GroupDto>> findAll() async {
    final result =
        groups.map((groupMap) => GroupDto.fromMap(groupMap)).toList();

    return result;
  }

  @override
  Future<GroupDto?> findByDescription(String description) async {
    final result =
        groups.where((element) => element['description'] == description);
    if (result.isEmpty) {
      return null;
    }
    return GroupDto.fromMap(result.first);
  }

  @override
  Future<GroupDto?> findById(String id) async {
    final result = groups.where((element) => element['id'] == id);
    if (result.isEmpty) {
      return null;
    }
    return GroupDto.fromMap(result.first);
  }

  @override
  Future<void> remove(String id) async {
    groups.removeWhere((element) => element['id'] == id);
  }

  @override
  Future<GroupDto> save(GroupEntity groupEntity) async {
    final groupDto = GroupDto(
        id: groupEntity.id,
        description: groupEntity.description,
        createdAt: groupEntity.createdAt,
        updatedAt: groupEntity.updatedAt);
    final groupMap = groupDto.toMap();
    groups.add(groupMap);

    return groupDto;
  }

  @override
  Future<GroupDto?> update(String id, GroupEntity groupEntity) async {
    final result = groups.where((element) => element['id'] == id);
    if (result.isEmpty) {
      return null;
    }
    final groupDto = GroupDto(
        id: groupEntity.id,
        description: groupEntity.description,
        createdAt: groupEntity.createdAt,
        updatedAt: groupEntity.updatedAt);
    final groupMap = groupDto.toMap();

    groups.removeWhere((element) => element['id'] == id);
    groups.add(groupMap);
    return Future.value(groupDto);
  }
}

List<Map<String, dynamic>> groups = [
  {
    "id": "1",
    "description": "group 1",
    "createdAt": "2023-01-01",
    "updatedAt": null
  },
  {
    "id": "2",
    "description": "group 2",
    "createdAt": "2023-01-01",
    "updatedAt": null
  },
  {
    "id": "3",
    "description": "group 3",
    "createdAt": "2023-01-01",
    "updatedAt": null
  },
];
