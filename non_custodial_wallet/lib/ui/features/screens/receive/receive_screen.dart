import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../../../ui/core/extensions/context_extension.dart';
import '../../../../ui/core/mixins/social_mixin.dart';
import '../../../../ui/core/di.dart';
import '../../cubits/receive/receive_cubit.dart';
import '../../cubits/receive/receive_state.dart';

class ReceiveScreen extends StatelessWidget {
  const ReceiveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ReceiveCubit>()..init('BTC'),
      child: const ReceiveScreenView(),
    );
  }
}

class ReceiveScreenView extends StatelessWidget with SocialMixin {
  const ReceiveScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ReceiveCubit>();

    return BlocBuilder<ReceiveCubit, ReceiveState>(
      builder: (context, state) {
        // Construct QR Data: address + ?amount=value if amount is set
        String qrData = state.address;
        if (state.amount.isNotEmpty &&
            double.tryParse(state.amount) != null &&
            double.parse(state.amount) > 0) {
          final prefix = state.selectedNetwork == 'BTC'
              ? 'bitcoin:'
              : 'ethereum:';
          qrData = '$prefix${state.address}?amount=${state.amount}';
        }

        return Scaffold(
          backgroundColor: const Color(0xFF0F2027),
          appBar: AppBar(
            title: Text(
              context.l10n.receiveButton, // Reuse receive translation
              style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Network Selector
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    context.l10n.networkLabel,
                    style: GoogleFonts.poppins(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.white12),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: state.selectedNetwork,
                      isExpanded: true,
                      dropdownColor: const Color(0xFF1E2A32),
                      icon: const Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.white70,
                      ),
                      items: cubit.networks.map((String network) {
                        return DropdownMenuItem<String>(
                          value: network,
                          child: Text(
                            network,
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          cubit.updateNetwork(newValue);
                        }
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 40),

                // QR Code Container
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: QrImageView(
                    data: qrData.isNotEmpty ? qrData : ' ',
                    version: QrVersions.auto,
                    size: 200.0,
                    backgroundColor: Colors.white,
                  ),
                ),
                const SizedBox(height: 24),

                // Address Text
                Text(
                  state.address,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 40),

                // Action Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildActionButton(
                      icon: Icons.copy,
                      label: "Copy",
                      onTap: () {
                        if (state.address.isNotEmpty) {
                          copyToClipboard(
                            context,
                            state.address,
                            context.l10n.copiedToClipboard,
                          );
                        }
                      },
                    ),
                    _buildActionButton(
                      icon: Icons.edit,
                      label: "Set Amount",
                      onTap: () =>
                          _showAmountDialog(context, cubit, state.amount),
                    ),
                    _buildActionButton(
                      icon: Icons.share,
                      label: "Share",
                      onTap: () {
                        if (state.address.isNotEmpty) {
                          shareText(
                            state.address,
                            subject: "My Wallet Address",
                          );
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blueAccent.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: Colors.blueAccent, size: 24),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: GoogleFonts.poppins(color: Colors.white70, fontSize: 12),
            ),
          ],
        ),
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
          backgroundColor: const Color(0xFF1E2A32),
          title: Text(
            "Set Amount",
            style: GoogleFonts.poppins(color: Colors.white),
          ),
          content: TextField(
            controller: cubit.amountController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            style: GoogleFonts.poppins(color: Colors.white),
            decoration: InputDecoration(
              hintText: "0.00",
              hintStyle: GoogleFonts.poppins(color: Colors.white38),
              filled: true,
              fillColor: Colors.white.withOpacity(0.05),
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
                "Close",
                style: GoogleFonts.poppins(color: Colors.blueAccent),
              ),
            ),
          ],
        );
      },
    );
  }
}
