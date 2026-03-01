import 'package:non_custodial_wallet/data/datasources/auth/auth_datasource.dart';
import 'package:non_custodial_wallet/domain/repositories/auth/i_auth_repository.dart';

import '../../../domain/core/result.dart';


class AuthRepositoryImpl implements IAuthRepository {
  final AuthDataSource authDataSource;

  AuthRepositoryImpl({required this.authDataSource});

  @override
  String generateMnemonic() {
    return authDataSource.generateMnemonic();
  }

  @override
  Future<String> generateMnemonicAsync() {
    return authDataSource.generateMnemonicAsync();
  }

  @override
  bool validateMnemonic(String mnemonic) {
    return authDataSource.validateMnemonic(mnemonic);
  }

  @override
  Future<Result<void>> saveMnemonic(String mnemonic) {
    return authDataSource.saveMnemonic(mnemonic);
  }

  @override
  Future<Result<String?>> getStoredMnemonic() {
    return authDataSource.getStoredMnemonic();
  }

  @override
  Future<Result<void>> deleteMnemonic() {
    return authDataSource.deleteMnemonic();
  }
}
