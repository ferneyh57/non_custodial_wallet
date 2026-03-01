import '../../../ui/core/util/result.dart';

abstract class IPinRepository {
  Future<Result<void>> savePin(String pin);
  Future<Result<bool>> verifyPin(String pin);
  Future<Result<bool>> hasPin();
  Future<Result<void>> deletePin();
}
