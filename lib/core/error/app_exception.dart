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

class DriveException extends AppException {
  const DriveException(super.message);
}

class AuthException extends AppException {
  const AuthException([super.message = '인증에 실패했습니다.']);
}

class ConflictException extends AppException {
  const ConflictException(this.lockCreatedAt)
      : super('다른 기기에서 이미 접속 중입니다.');
  final DateTime lockCreatedAt;
}

class ValidationException extends AppException {
  const ValidationException(super.message);
}
