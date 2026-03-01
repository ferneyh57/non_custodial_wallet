import '../network/network_entity.dart';
import '../token/token_balance_entity.dart';

class TokenDetailArgs {
  final NetworkEntity network;
  final TokenBalanceEntity? tokenBalance;
  final double? nativeBalance;
  final double? price;

  const TokenDetailArgs({
    required this.network,
    this.tokenBalance,
    this.nativeBalance,
    this.price,
  });

  bool get isToken => tokenBalance != null;

  String get symbol =>
      isToken ? tokenBalance!.token.symbol : network.nativeSymbol;

  String get displayName =>
      isToken ? tokenBalance!.token.name : network.shortName;

  String get iconUrl =>
      isToken ? tokenBalance!.token.logoUrl : network.iconUrl;

  double get balanceFormatted =>
      isToken ? tokenBalance!.balanceFormatted : (nativeBalance ?? 0.0);

  double get usdValue => balanceFormatted * (price ?? 0.0);

  String? get contractAddress =>
      isToken ? tokenBalance!.token.contractAddress : null;
}
