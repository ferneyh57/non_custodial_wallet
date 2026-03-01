import 'package:flutter/material.dart';

import '../../../core/extensions/context_extension.dart';

class PinDisplay extends StatelessWidget {
  final int filledCount;
  final int pinLength;
  final bool hasError;

  const PinDisplay({
    super.key,
    required this.filledCount,
    required this.pinLength,
    this.hasError = false,
  });

  @override
  Widget build(BuildContext context) {
    final activeColor =
        hasError ? context.colors.error : context.colors.primary;
    final inactiveColor = context.appColors.cardBorder;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(pinLength, (index) {
        final isFilled = index < filledCount;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          margin: const EdgeInsets.symmetric(horizontal: 8),
          width: isFilled ? 16 : 14,
          height: isFilled ? 16 : 14,
          decoration: BoxDecoration(
            color: isFilled ? activeColor : Colors.transparent,
            shape: BoxShape.circle,
            border: Border.all(
              color: isFilled ? activeColor : inactiveColor,
              width: 2,
            ),
          ),
        );
      }),
    );
  }
}
