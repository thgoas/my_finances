import 'package:my_finances/layers/groups/domain/entities/group_entity.dart';

abstract class GroupPageState {}

class GroupPageLoadingState extends GroupPageState {}

class GroupPageStartState extends GroupPageState {}

class GroupPageSuccessfulState extends GroupPageState {
  final List<GroupEntity> groups;

  GroupPageSuccessfulState(this.groups);
}

class GroupPageErrorState extends GroupPageState {
  final String errorMessage;

  GroupPageErrorState(this.errorMessage);
}
