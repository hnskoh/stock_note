sealed class AppException implements Exception {
  const AppException(this.message);
  final String message;

  @override
  String toString() => '$runtimeType: $message';
}

class DatabaseException extends AppException {
  const DatabaseException(super.message);
}

class NetworkException extends AppException {
  const NetworkException([super.message = '네트워크에 연결할 수 없습니다.']);
}

class AuthException extends AppException {
  const AuthException([super.message = '인증에 실패했습니다.']);
}

class ValidationException extends AppException {
  const ValidationException(super.message);
}
