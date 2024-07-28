import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:my_finances/core/inject/inject.dart';
import 'package:my_finances/layers/groups/presentation/controller/group_controller.dart';
import 'package:my_finances/layers/groups/presentation/states/group_state.dart';

void main() {
  Inject.init();
  final controller = GetIt.instance.get<GroupController>();
  test('should return GroupPageSuccessfulState with id 1', () async {
    await controller.getGroupById('1');
    expect(controller.state.value, isA<GroupPageSuccessfulState>());

    final state = controller.state.value as GroupPageSuccessfulState;
    expect(state.groups[0].id, '1');
  });
  test('should return GroupPageErrorState when id empty', () async {
    await controller.getGroupById('');
    expect(controller.state.value, isA<GroupPageErrorState>());

    final state = controller.state.value as GroupPageErrorState;
    expect(state.errorMessage, 'Invalid id');
  });

  test('should return GroupPageErrorState when id not exist', () async {
    await controller.getGroupById('100');
    expect(controller.state.value, isA<GroupPageErrorState>());

    final state = controller.state.value as GroupPageErrorState;
    expect(state.errorMessage, 'No data found');
  });

  test('should return GroupPageSuccessfulState with description group 1',
      () async {
    await controller.getGroupByDescription('group 1');
    expect(controller.state.value, isA<GroupPageSuccessfulState>());

    final state = controller.state.value as GroupPageSuccessfulState;
    expect(state.groups[0].description, 'group 1');
  });

  test('should return GroupPageErrorState when description empty', () async {
    await controller.getGroupByDescription('');
    expect(controller.state.value, isA<GroupPageErrorState>());

    final state = controller.state.value as GroupPageErrorState;
    expect(state.errorMessage, 'Invalid Description');
  });

  test('should return GroupPageErrorState when description not exist',
      () async {
    await controller.getGroupByDescription('note found');
    expect(controller.state.value, isA<GroupPageErrorState>());

    final state = controller.state.value as GroupPageErrorState;
    expect(state.errorMessage, 'No data found');
  });

  test('should return GroupPageSuccessfulState with all groups', () async {
    await controller.getAllGroup();
    expect(controller.state.value, isA<GroupPageSuccessfulState>());

    final state = controller.state.value as GroupPageSuccessfulState;
    expect(state.groups.length, 3);
  });

  test('should create a new group', () async {
    await controller.newGroup('new group');
    expect(controller.state.value, isA<GroupPageSuccessfulState>());

    final state = controller.state.value as GroupPageSuccessfulState;
    expect(state.groups[0].description, 'new group');
  });

  test('should return GroupPageErrorState when create a new group empty',
      () async {
    await controller.newGroup('');
    expect(controller.state.value, isA<GroupPageErrorState>());

    final state = controller.state.value as GroupPageErrorState;
    expect(state.errorMessage, 'description can not Empty');
  });

  test('should update group with id 1', () async {
    await controller.updateGroup('1', 'group 1 edited');
    expect(controller.state.value, isA<GroupPageSuccessfulState>());

    final state = controller.state.value as GroupPageSuccessfulState;
    expect(state.groups[0].description, 'group 1 edited');
  });

  test('should return GroupPageErrorState when update group id empty',
      () async {
    await controller.updateGroup('', 'edited group 1');
    expect(controller.state.value, isA<GroupPageErrorState>());
    final state = controller.state.value as GroupPageErrorState;
    expect(state.errorMessage, 'Id can not empty');
  });
  test('should return GroupPageErrorState when update group id not exist',
      () async {
    await controller.updateGroup('100', 'edited group 100');
    expect(controller.state.value, isA<GroupPageErrorState>());
    final state = controller.state.value as GroupPageErrorState;
    expect(state.errorMessage, 'No data found');
  });

  test('should return GroupPageErrorState when update group description empty',
      () async {
    await controller.updateGroup('1', '');
    expect(controller.state.value, isA<GroupPageErrorState>());
    final state = controller.state.value as GroupPageErrorState;
    expect(state.errorMessage, 'description can not empty');
  });

  test('should delete group with id 1', () async {
    await controller.removeGroup('1');
    expect(controller.state.value, isA<GroupPageSuccessfulState>());

    final state = controller.state.value as GroupPageSuccessfulState;
    expect(state.groups[0].description, 'group 1 edited');
  });

  test('should return GroupPageErrorState when id empty', () async {
    await controller.removeGroup('');
    expect(controller.state.value, isA<GroupPageErrorState>());
    final state = controller.state.value as GroupPageErrorState;
    expect(state.errorMessage, 'Id can not empty');
  });

  test('should return GroupPageErrorState when id not exits', () async {
    await controller.removeGroup('100');
    expect(controller.state.value, isA<GroupPageErrorState>());
    final state = controller.state.value as GroupPageErrorState;
    expect(state.errorMessage, 'No data found');
  });
}
