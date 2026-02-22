import 'package:flutter_bloc/flutter_bloc.dart';
import 'wallet_state.dart';

class WalletCubit extends Cubit<WalletState> {
  WalletCubit() : super(WalletState());
}
