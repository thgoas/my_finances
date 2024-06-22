abstract class FailureGroup implements Exception {
  final String message;

  FailureGroup(this.message);
}

class InvalidIdError extends FailureGroup {
  InvalidIdError(super.message);
}

class InvalidDescriptionError extends FailureGroup {
  InvalidDescriptionError(super.message);
}
