class ServerException implements Exception {
  final String message;
  ServerException([this.message = 'Server Exception']);
}

class CacheException implements Exception {
  final String message;
  CacheException([this.message = 'Cache Exception']);
}

class SecureStorageException implements Exception {
  final String message;
  SecureStorageException([this.message = 'Secure Storage Exception']);
}
