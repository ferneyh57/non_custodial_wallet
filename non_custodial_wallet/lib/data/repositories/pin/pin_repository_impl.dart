import '../../datasources/pin/pin_datasource.dart';
import '../../../domain/repositories/pin/i_pin_repository.dart';
import '../../../ui/core/util/result.dart';

class PinRepositoryImpl implements IPinRepository {
  final PinDataSource pinDataSource;

  const PinRepositoryImpl({required this.pinDataSource});

  @override
  Future<Result<void>> savePin(String pin) => pinDataSource.savePin(pin);

  @override
  Future<Result<bool>> verifyPin(String pin) => pinDataSource.verifyPin(pin);

  @override
  Future<Result<bool>> hasPin() => pinDataSource.hasPin();

  @override
  Future<Result<void>> deletePin() => pinDataSource.deletePin();
}
