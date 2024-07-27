import 'package:flutter/material.dart';
import 'package:my_finances/layers/groups/domain/usecases/get_group_by_id_usecase.dart';
import 'package:my_finances/layers/groups/presentation/states/group_state.dart';

class GroupController {
  var state = ValueNotifier<GroupPageState>(GroupPageStartState());
  final GetGroupByIdUseCase _getGroupByIdUseCase;
  GroupController(this._getGroupByIdUseCase);

  getGroupById(String id) async {
    state.value = GroupPageLoadingState();

    final result = await _getGroupByIdUseCase(id);

    result.fold((failure) {
      state.value = GroupPageErrorState(failure.message);
    }, (group) {
      state.value = GroupPageSuccessfulState(group);
    });
  }
}
