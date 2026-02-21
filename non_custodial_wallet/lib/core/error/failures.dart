abstract class Failure {
  final String message;
  const Failure(this.message);

  @override
  String toString() => message;
}

class ServerFailure extends Failure {
  const ServerFailure([super.message = 'Server Error']);
}

class CacheFailure extends Failure {
  const CacheFailure([super.message = 'Cache Error']);
}

class ValidationFailure extends Failure {
  const ValidationFailure([super.message = 'Validation Error']);
}

class SecureStorageFailure extends Failure {
  const SecureStorageFailure([super.message = 'Secure Storage Error']);
}
