import 'package:my_finances/layers/groups/domain/errors/failure_group.dart';

class NoElementDataSourceError extends FailureGroup {
  NoElementDataSourceError(super.message);
}

class EmptyResultException extends FailureGroup {
  EmptyResultException(super.message);
}
