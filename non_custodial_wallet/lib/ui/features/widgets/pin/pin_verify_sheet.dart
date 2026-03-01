import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/di.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../../domain/usecases/pin/verify_pin_use_case.dart';
import '../../cubits/pin/pin_cubit.dart';
import 'pin_display.dart';
import 'pin_keypad.dart';

class PinVerifySheet extends StatefulWidget {
  const PinVerifySheet({super.key});

  static Future<bool> show(BuildContext context) async {
    final result = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const PinVerifySheet(),
    );
    return result ?? false;
  }

  @override
  State<PinVerifySheet> createState() => _PinVerifySheetState();
}

class _PinVerifySheetState extends State<PinVerifySheet> {
  String _pin = '';
  String? _error;
  bool _verifying = false;

  Future<void> _onDigit(String digit) async {
    if (_verifying || _pin.length >= PinCubit.pinLength) return;
    setState(() {
      _pin += digit;
      _error = null;
    });

    if (_pin.length == PinCubit.pinLength) {
      setState(() => _verifying = true);
      final result = await sl<VerifyPinUseCase>()(_pin);
      if (!mounted) return;

      if (result.isSuccess && result.data == true) {
        Navigator.of(context).pop(true);
      } else {
        setState(() {
          _pin = '';
          _error = context.l10n.pinIncorrectError;
          _verifying = false;
        });
      }
    }
  }

  void _onDelete() {
    if (_pin.isEmpty || _verifying) return;
    setState(() {
      _pin = _pin.substring(0, _pin.length - 1);
      _error = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.only(top: 24, bottom: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: context.appColors.subtitleText.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                context.l10n.pinVerifyTitle,
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                context.l10n.pinVerifySubtitle,
                style: GoogleFonts.poppins(
                  color: context.appColors.subtitleText,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 32),
              PinDisplay(
                filledCount: _pin.length,
                pinLength: PinCubit.pinLength,
                hasError: _error != null,
              ),
              if (_error != null) ...[
                const SizedBox(height: 16),
                Text(
                  _error!,
                  style: GoogleFonts.poppins(
                    color: context.colors.error,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
              const SizedBox(height: 32),
              PinKeypad(
                onDigit: _onDigit,
                onDelete: _onDelete,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
