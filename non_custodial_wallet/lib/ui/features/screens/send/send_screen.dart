import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../ui/core/extensions/context_extension.dart';
import '../../../../ui/core/di.dart';
import '../../cubits/send/send_cubit.dart';
import '../../cubits/send/send_state.dart';
import '../../widgets/network_dropdown.dart';

class SendScreen extends StatelessWidget {
  const SendScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<SendCubit>()..loadWalletData(),
      child: const SendScreenView(),
    );
  }
}

class SendScreenView extends StatelessWidget {
  const SendScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SendCubit>();

    return BlocConsumer<SendCubit, SendState>(
      listener: (context, state) {
        if (state.txHash != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Transaction Sent! Hash: ${state.txHash}'),
              backgroundColor: Colors.green,
            ),
          );
        } else if (state.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage!),
              backgroundColor: context.colors.error,
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              context.l10n.sendTitle,
              style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Network Selector
                Text(
                  context.l10n.networkLabel,
                  style: GoogleFonts.poppins(
                    color: context.appColors.subtitleText,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                NetworkDropdown(
                  value: state.selectedNetwork,
                  networks: cubit.networks,
                  onChanged: (network) {
                    if (network != null) cubit.updateNetwork(network);
                  },
                ),
                const SizedBox(height: 24),

                // Address Input Card
                Text(
                  context.l10n.addressHint,
                  style: GoogleFonts.poppins(
                    color: context.appColors.subtitleText,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                    color: context.appColors.cardColor,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: context.appColors.cardBorder),
                  ),
                  child: TextField(
                    controller: cubit.addressController,
                    style:
                        GoogleFonts.poppins(color: context.colors.onSurface),
                    decoration: InputDecoration(
                      hintText: '0x...',
                      filled: false,
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      suffixIcon: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.content_paste_rounded,
                              color: context.colors.primary,
                              size: 20,
                            ),
                            onPressed: () async {
                              final data =
                                  await Clipboard.getData('text/plain');
                              if (data?.text != null) {
                                cubit.addressController.text = data!.text!;
                              }
                            },
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.qr_code_scanner_rounded,
                              color: context.colors.primary,
                              size: 20,
                            ),
                            onPressed: () {
                              // TODO: Implement scanner logic
                            },
                          ),
                          const SizedBox(width: 4),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Amount Input Card
                Text(
                  context.l10n.amountHint,
                  style: GoogleFonts.poppins(
                    color: context.appColors.subtitleText,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                    color: context.appColors.cardColor,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: context.appColors.cardBorder),
                  ),
                  child: TextField(
                    controller: cubit.amountController,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    style:
                        GoogleFonts.poppins(color: context.colors.onSurface),
                    decoration: InputDecoration(
                      hintText: '0.00',
                      filled: false,
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: TextButton(
                          onPressed: () => cubit.setMaxAmount(),
                          style: TextButton.styleFrom(
                            foregroundColor: context.colors.primary,
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: Text(
                            context.l10n.maxButton,
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 48),

                // Send Button with gradient
                SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: state.isLoading
                          ? null
                          : LinearGradient(
                              colors: [
                                context.appColors.balanceCardGradientStart,
                                context.appColors.balanceCardGradientEnd,
                              ],
                            ),
                      color: state.isLoading
                          ? context.appColors.containerFill
                          : null,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: state.isLoading
                          ? null
                          : [
                              BoxShadow(
                                color: context.colors.primary
                                    .withValues(alpha: 0.3),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ],
                    ),
                    child: ElevatedButton(
                      onPressed:
                          state.isLoading ? null : () => cubit.sendTransaction(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: state.isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : Text(
                              context.l10n.sendAction,
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
