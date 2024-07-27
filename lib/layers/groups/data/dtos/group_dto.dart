import 'dart:convert';

import 'package:my_finances/layers/groups/domain/entities/group_entity.dart';

class GroupDto extends GroupEntity {
  GroupDto(
      {required super.id,
      required super.description,
      required super.createdAt,
      required super.updatedAt});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'description': description,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  factory GroupDto.fromMap(Map<String, dynamic> map) {
    return GroupDto(
      id: map['id'] as String,
      description: map['description'] as String,
      createdAt: map['createdAt'] == null
          ? null
          : DateTime.parse(map['createdAt'] as String),
      updatedAt: map['updatedAt'] == null
          ? null
          : DateTime.parse(map['updatedAt'] as String),
    );
  }

  String toJson() => json.encode(toMap());

  factory GroupDto.fromJson(String source) =>
      GroupDto.fromMap(json.decode(source) as Map<String, dynamic>);
  @override
  String toString() {
    return toJson().toString();
  }
}
