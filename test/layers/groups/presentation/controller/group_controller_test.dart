import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:my_finances/core/inject/inject.dart';
import 'package:my_finances/layers/groups/presentation/controller/group_controller.dart';
import 'package:my_finances/layers/groups/presentation/states/group_state.dart';

void main() {
  Inject.init();
  test('should return GroupPageSuccessfulState with id 1', () async {
    final controller = GetIt.instance.get<GroupController>();

    await controller.getGroupById('1');
    expect(controller.state.value, isA<GroupPageSuccessfulState>());

    final state = controller.state.value as GroupPageSuccessfulState;
    expect(state.groupEntity.id, '1');
  });

  // test('should return a group id with 1', () async {
  //   final controller = GetIt.instance.get<GroupController>();

  //   await controller.getOneGroup('4');
  //   expect(controller.state.value, isA<GroupPageErrorState>());
  // });
}
