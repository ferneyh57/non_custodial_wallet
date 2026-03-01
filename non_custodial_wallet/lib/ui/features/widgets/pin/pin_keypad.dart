import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/extensions/context_extension.dart';

class PinKeypad extends StatelessWidget {
  final ValueChanged<String> onDigit;
  final VoidCallback onDelete;

  const PinKeypad({
    super.key,
    required this.onDigit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        children: [
          for (final row in [
            ['1', '2', '3'],
            ['4', '5', '6'],
            ['7', '8', '9'],
            ['', '0', 'del'],
          ])
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: row.map((key) {
                  if (key.isEmpty) {
                    return const SizedBox(width: 72, height: 72);
                  }
                  if (key == 'del') {
                    return _KeypadButton(
                      onTap: onDelete,
                      child: Icon(
                        Icons.backspace_outlined,
                        color: context.colors.onSurface,
                        size: 24,
                      ),
                    );
                  }
                  return _KeypadButton(
                    onTap: () => onDigit(key),
                    child: Text(
                      key,
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: context.colors.onSurface,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
        ],
      ),
    );
  }
}

class _KeypadButton extends StatelessWidget {
  final VoidCallback onTap;
  final Widget child;

  const _KeypadButton({required this.onTap, required this.child});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(36),
        child: SizedBox(
          width: 72,
          height: 72,
          child: Center(child: child),
        ),
      ),
    );
  }
}
