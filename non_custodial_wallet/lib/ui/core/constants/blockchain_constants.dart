class BlockchainConstants {
  // Transfer categories
  static const String categoryExternal = 'external';
  static const String categoryErc20 = 'erc20';
  static const List<String> defaultTransferCategories = [
    categoryExternal,
    categoryErc20,
  ];

  // Block range markers
  static const String fromBlockGenesis = '0x0';
  static const String toBlockLatest = 'latest';

  // Sort order
  static const String orderDesc = 'desc';

  // ERC-20 contract function
  static const String transferFunction = 'transfer';

  // Minimal ERC-20 ABI: transfer(address,uint256) → bool
  static const String erc20TransferAbi =
      '[{"constant":false,"inputs":[{"name":"_to","type":"address"},{"name":"_value","type":"uint256"}],"name":"transfer","outputs":[{"name":"","type":"bool"}],"type":"function"}]';
}
