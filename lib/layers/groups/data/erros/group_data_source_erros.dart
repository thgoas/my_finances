import 'package:my_finances/layers/groups/domain/errors/failure_group.dart';

class NoElementDataSourceError extends FailureGroup {
  NoElementDataSourceError(super.message);
}

class DataSourceException extends FailureGroup {
  DataSourceException(super.message);
}
