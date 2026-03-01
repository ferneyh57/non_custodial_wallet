import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';
import '../../../domain/entities/network/network_entity.dart';
import '../../core/extensions/context_extension.dart';
import '../../core/di.dart';
import 'cubits/receive_cubit.dart';
import 'cubits/receive_state.dart';
import '../../commons/widgets/network_dropdown.dart';

class ReceiveScreen extends StatelessWidget {
  final NetworkEntity? initialNetwork;

  const ReceiveScreen({super.key, this.initialNetwork});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final cubit = sl<ReceiveCubit>();
        if (initialNetwork != null) {
          cubit.updateNetwork(initialNetwork!);
        }
        return cubit;
      },
      child: const ReceiveScreenView(),
    );
  }
}

class ReceiveScreenView extends StatelessWidget {
  const ReceiveScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ReceiveCubit>();

    return BlocBuilder<ReceiveCubit, ReceiveState>(
      builder: (context, state) {
        String qrData = state.address;
        if (state.amount.isNotEmpty &&
            double.tryParse(state.amount) != null &&
            double.parse(state.amount) > 0) {
          qrData = 'ethereum:${state.address}?amount=${state.amount}';
        }

        final truncatedAddress = state.address.length > 10
            ? '${state.address.substring(0, 6)}...${state.address.substring(state.address.length - 4)}'
            : state.address;

        return SafeArea(
          top: false,
          child: Scaffold(
            appBar: AppBar(
              title: Text(
                context.l10n.receiveButton,
                style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
            ),
            body: SafeArea(
              top: false,
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Network Selector
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        context.l10n.networkLabel,
                        style: GoogleFonts.poppins(
                          color: context.appColors.subtitleText,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
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
                    const SizedBox(height: 32),
          
                    // QR Code Card
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: context.appColors.cardColor,
                        borderRadius: BorderRadius.circular(28),
                        border: Border.all(color: context.appColors.cardBorder),
                        boxShadow: [
                          BoxShadow(
                            color: context.colors.primary.withValues(alpha: 0.08),
                            blurRadius: 20,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: QrImageView(
                              data: qrData.isNotEmpty ? qrData : ' ',
                              version: QrVersions.auto,
                              size: 200.0,
                              backgroundColor: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 20),
                          // Truncated address with copy button
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                truncatedAddress,
                                style: GoogleFonts.poppins(
                                  color: context.colors.onSurface,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.5,
                                ),
                              ),
                              const SizedBox(width: 8),
                              InkWell(
                                onTap: () => _copyAddress(context, state.address),
                                borderRadius: BorderRadius.circular(8),
                                child: Padding(
                                  padding: const EdgeInsets.all(4),
                                  child: Icon(
                                    Icons.copy_rounded,
                                    color: context.colors.primary,
                                    size: 18,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
          
                    // Action Buttons as Cards
                    Row(
                      children: [
                        Expanded(
                          child: ReceiveActionCard(
                            icon: Icons.copy_rounded,
                            label: context.l10n.copyTooltip,
                            onTap: () => _copyAddress(context, state.address),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ReceiveActionCard(
                            icon: Icons.edit_rounded,
                            label: context.l10n.amountHint,
                            onTap: () =>
                                _showAmountDialog(context, cubit, state.amount),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ReceiveActionCard(
                            icon: Icons.share_rounded,
                            label: context.l10n.sendButton == 'Send'
                                ? 'Share'
                                : 'Compartir',
                            onTap: () {
                              if (state.address.isNotEmpty) {
                                SharePlus.instance.share(
                                  ShareParams(text: state.address),
                                );
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _copyAddress(BuildContext context, String address) {
    if (address.isEmpty) return;
    Clipboard.setData(ClipboardData(text: address));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(context.l10n.copiedToClipboard),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showAmountDialog(
    BuildContext context,
    ReceiveCubit cubit,
    String currentAmount,
  ) {
    cubit.amountController.text = currentAmount;
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          backgroundColor: context.colors.surfaceContainerHighest,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            context.l10n.amountHint,
            style: GoogleFonts.poppins(color: context.colors.onSurface),
          ),
          content: TextField(
            controller: cubit.amountController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            style: GoogleFonts.poppins(color: context.colors.onSurface),
            decoration: InputDecoration(
              hintText: '0.00',
              filled: true,
              fillColor: context.appColors.containerFill,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: Text(
                'OK',
                style: GoogleFonts.poppins(color: context.colors.primary),
              ),
            ),
          ],
        );
      },
    );
  }
}

class ReceiveActionCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const ReceiveActionCard({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.appColors.cardColor,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: context.appColors.cardBorder),
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: context.colors.primary.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: context.colors.primary, size: 22),
              ),
              const SizedBox(height: 8),
              Text(
                label,
                style: GoogleFonts.poppins(
                  color: context.appColors.subtitleText,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
