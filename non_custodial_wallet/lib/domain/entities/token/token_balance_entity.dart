import 'token_entity.dart';

class TokenBalanceEntity {
  final TokenEntity token;
  final int chainId;
  final BigInt balanceRaw;

  const TokenBalanceEntity({
    required this.token,
    required this.chainId,
    required this.balanceRaw,
  });

  double get balanceFormatted {
    if (balanceRaw == BigInt.zero) return 0.0;
    final divisor = BigInt.from(10).pow(token.decimals);
    return balanceRaw / divisor;
  }
}
