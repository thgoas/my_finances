import 'package:get_it/get_it.dart';
import 'package:my_finances/layers/groups/data/repositories/group_repository_imp.dart';
import 'package:my_finances/layers/groups/data/sources/group_data_source.dart';
import 'package:my_finances/layers/groups/data/sources/inMemory/group_data_source_in_memory.dart';
import 'package:my_finances/layers/groups/domain/repositories/group_repository.dart';
import 'package:my_finances/layers/groups/domain/usecases/delete_group_usecase.dart';
import 'package:my_finances/layers/groups/domain/usecases/delete_group_usecase_imp.dart';
import 'package:my_finances/layers/groups/domain/usecases/get_all_groups_usecase.dart';
import 'package:my_finances/layers/groups/domain/usecases/get_all_groups_usecase_imp.dart';
import 'package:my_finances/layers/groups/domain/usecases/get_group_by_description_usecase.dart';
import 'package:my_finances/layers/groups/domain/usecases/get_group_by_description_usecase_imp.dart';
import 'package:my_finances/layers/groups/domain/usecases/get_group_by_id_usecase.dart';
import 'package:my_finances/layers/groups/domain/usecases/get_group_by_id_usecase_imp.dart';
import 'package:my_finances/layers/groups/domain/usecases/new_group_usecase.dart';
import 'package:my_finances/layers/groups/domain/usecases/new_group_usecase_imp.dart';
import 'package:my_finances/layers/groups/domain/usecases/update_group_usecase.dart';
import 'package:my_finances/layers/groups/domain/usecases/update_group_usecase_imp.dart';
import 'package:my_finances/layers/groups/presentation/controller/group_controller.dart';

class Inject {
  static void init() {
    GetIt getIt = GetIt.instance;
    //data sources
    getIt.registerLazySingleton<GroupDataSource>(
        () => GroupDataSourceInMemory());
    //repository
    getIt.registerLazySingleton<GroupRepository>(
        () => GroupRepositoryImp(getIt()));
    //use cases
    getIt.registerLazySingleton<NewGroupUseCase>(
        () => NewGroupUseCaseImp(getIt()));
    getIt.registerLazySingleton<UpdateGroupUseCase>(
        () => UpdateGroupUseCaseImp(getIt()));
    getIt.registerLazySingleton<GetAllGroupsUseCase>(
        () => GetAllGroupsUseCaseImp(getIt()));
    getIt.registerLazySingleton<GetGroupByDescriptionUseCase>(
        () => GetGroupByDescriptionUseCaseImp(getIt()));
    getIt.registerLazySingleton<GetGroupByIdUseCase>(
        () => GetGroupByIdUseCaseImp(getIt()));
    getIt.registerLazySingleton<DeleteGroupUseCase>(
        () => DeleteGroupUseCaseImp(getIt()));

    getIt.registerFactory<GroupController>(() =>
        GroupController(getIt(), getIt(), getIt(), getIt(), getIt(), getIt()));
  }
}
