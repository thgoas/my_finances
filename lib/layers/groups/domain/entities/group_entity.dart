class GroupEntity {
  final String id;
  final String description;
  final DateTime createdAt;
  final DateTime updatedAt;

  GroupEntity(
      {required this.id,
      required this.description,
      required this.createdAt,
      required this.updatedAt});
}
