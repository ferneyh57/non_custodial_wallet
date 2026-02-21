import 'package:flutter/material.dart';
import '../services/wallet_service.dart';
import '../services/secure_storage_service.dart';

class WalletProvider with ChangeNotifier {
  final WalletService _walletService = WalletService();
  final SecureStorageService _storageService = SecureStorageService();

  String? _mnemonic;
  String? _btcAddress;
  String? _ethAddress;
  bool _isLoading = false;

  String? get mnemonic => _mnemonic;
  String? get btcAddress => _btcAddress;
  String? get ethAddress => _ethAddress;
  bool get isLoading => _isLoading;

  Future<void> createNewWallet() async {
    _isLoading = true;
    notifyListeners();

    _mnemonic = _walletService.generateMnemonic();
    _ethAddress = await _walletService.getEthAddress(_mnemonic!);
    _btcAddress = await _walletService.getBtcAddress(_mnemonic!);

    _isLoading = false;
    notifyListeners();
  }

  Future<bool> importWallet(String mnemonic) async {
    if (!_walletService.validateMnemonic(mnemonic)) return false;

    _isLoading = true;
    notifyListeners();

    _mnemonic = mnemonic;
    _ethAddress = await _walletService.getEthAddress(_mnemonic!);
    _btcAddress = await _walletService.getBtcAddress(_mnemonic!);

    await _storageService.saveMnemonic(_mnemonic!);

    _isLoading = false;
    notifyListeners();
    return true;
  }

  Future<void> saveMnemonic() async {
    if (_mnemonic != null) {
      await _storageService.saveMnemonic(_mnemonic!);
    }
  }

  Future<void> loadWallet() async {
    final storedMnemonic = await _storageService.getMnemonic();
    if (storedMnemonic != null) {
      await importWallet(storedMnemonic);
    }
  }

  Future<void> logout() async {
    await _storageService.deleteMnemonic();
    _mnemonic = null;
    _btcAddress = null;
    _ethAddress = null;
    notifyListeners();
  }
}
