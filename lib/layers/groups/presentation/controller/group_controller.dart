import 'package:flutter/material.dart';
import 'package:my_finances/layers/groups/domain/usecases/delete_group_usecase.dart';
import 'package:my_finances/layers/groups/domain/usecases/get_all_groups_usecase.dart';
import 'package:my_finances/layers/groups/domain/usecases/get_group_by_description_usecase.dart';
import 'package:my_finances/layers/groups/domain/usecases/get_group_by_id_usecase.dart';
import 'package:my_finances/layers/groups/domain/usecases/new_group_usecase.dart';
import 'package:my_finances/layers/groups/domain/usecases/update_group_usecase.dart';
import 'package:my_finances/layers/groups/presentation/states/group_state.dart';

class GroupController {
  var state = ValueNotifier<GroupPageState>(GroupPageStartState());
  final GetGroupByIdUseCase _getGroupByIdUseCase;
  final GetGroupByDescriptionUseCase _getGroupByDescriptionUseCase;
  final GetAllGroupsUseCase _getAllGroupsUseCase;
  final NewGroupUseCase _newGroupUseCase;
  final UpdateGroupUseCase _updateGroupUseCase;
  final DeleteGroupUseCase _deleteGroupUseCase;
  GroupController(
      this._getGroupByIdUseCase,
      this._getGroupByDescriptionUseCase,
      this._getAllGroupsUseCase,
      this._newGroupUseCase,
      this._updateGroupUseCase,
      this._deleteGroupUseCase);

  getGroupById(String id) async {
    state.value = GroupPageLoadingState();

    final result = await _getGroupByIdUseCase(id);

    result.fold((failure) {
      state.value = GroupPageErrorState(failure.message);
    }, (group) {
      state.value = GroupPageSuccessfulState([group]);
    });
  }

  getGroupByDescription(String description) async {
    state.value = GroupPageLoadingState();

    final result = await _getGroupByDescriptionUseCase(description);

    result.fold((failure) {
      state.value = GroupPageErrorState(failure.message);
    }, (group) {
      state.value = GroupPageSuccessfulState([group]);
    });
  }

  getAllGroup() async {
    state.value = GroupPageLoadingState();

    final result = await _getAllGroupsUseCase();

    result.fold((failure) {
      state.value = GroupPageErrorState(failure.message);
    }, (groups) {
      state.value = GroupPageSuccessfulState(groups);
    });
  }

  newGroup(String description) async {
    state.value = GroupPageLoadingState();

    final result = await _newGroupUseCase(description);

    result.fold((failure) {
      state.value = GroupPageErrorState(failure.message);
    }, (group) {
      state.value = GroupPageSuccessfulState([group]);
    });
  }

  updateGroup(String id, String description) async {
    state.value = GroupPageLoadingState();

    final result = await _updateGroupUseCase(id, description);

    result.fold((failure) {
      state.value = GroupPageErrorState(failure.message);
    }, (group) {
      state.value = GroupPageSuccessfulState([group]);
    });
  }

  removeGroup(String id) async {
    state.value = GroupPageLoadingState();

    final result = await _deleteGroupUseCase(id);

    result.fold((failure) {
      state.value = GroupPageErrorState(failure.message);
    }, (group) {
      state.value = GroupPageSuccessfulState([group]);
    });
  }
}
