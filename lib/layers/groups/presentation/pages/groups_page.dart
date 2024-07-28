import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:my_finances/layers/groups/presentation/controller/group_controller.dart';
import 'package:my_finances/layers/groups/presentation/states/group_state.dart';

class GroupsPage extends StatefulWidget {
  const GroupsPage({super.key});

  @override
  State<GroupsPage> createState() => _GroupsPageState();
}

class _GroupsPageState extends State<GroupsPage> {
  late final GroupController _groupController;
  final _inputText = TextEditingController();

  @override
  void initState() {
    super.initState();
    _groupController = GetIt.instance.get<GroupController>();
    _groupController.getAllGroup();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Groups'),
      ),
      body: Column(children: [
        Expanded(
          child: ValueListenableBuilder(
            valueListenable: _groupController.state,
            builder: (context, state, _) {
              switch (state.runtimeType) {
                case const (GroupPageStartState):
                  return const Center(
                    child: Center(
                      child: Text('Sem dados'),
                    ),
                  );
                case const (GroupPageLoadingState):
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                case const (GroupPageSuccessfulState):
                  final successFulState = state as GroupPageSuccessfulState;
                  return Center(
                    child: ListView.builder(
                      itemCount: successFulState.groups.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                            title: Text(
                                successFulState.groups[index].description));
                      },
                    ),
                  );
                case const (GroupPageErrorState):
                  final errorState = state as GroupPageErrorState;
                  return Center(
                    child: Text(errorState.errorMessage),
                  );
                default:
                  return Container();
              }
            },
          ),
        ),
      ]),
    );
  }
}
