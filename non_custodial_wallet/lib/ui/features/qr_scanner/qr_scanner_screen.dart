import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../../core/extensions/context_extension.dart';

class QrScannerScreen extends StatefulWidget {
  const QrScannerScreen({super.key});

  static bool get isSupported =>
      !kIsWeb && (Platform.isIOS || Platform.isAndroid);

  /// Shows the QR scanner and returns the scanned value, or null if cancelled.
  static Future<String?> show(BuildContext context) {
    if (!isSupported) return Future.value(null);
    return Navigator.of(context).push<String>(
      MaterialPageRoute(builder: (_) => const QrScannerScreen()),
    );
  }

  @override
  State<QrScannerScreen> createState() => _QrScannerScreenState();
}

class _QrScannerScreenState extends State<QrScannerScreen> {
  final _controller = MobileScannerController();
  bool _scanned = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onDetect(BarcodeCapture capture) {
    if (_scanned) return;
    final barcode = capture.barcodes.firstOrNull;
    if (barcode?.rawValue == null) return;

    _scanned = true;
    Navigator.of(context).pop(barcode!.rawValue);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: Text(
          context.l10n.qrScannerTitle,
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          ValueListenableBuilder(
            valueListenable: _controller,
            builder: (context, state, _) {
              final torchOn = state.torchState == TorchState.on;
              return IconButton(
                onPressed: () => _controller.toggleTorch(),
                icon: Icon(
                  torchOn ? Icons.flash_on_rounded : Icons.flash_off_rounded,
                  color: torchOn ? Colors.amber : Colors.white,
                ),
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          MobileScanner(
            controller: _controller,
            onDetect: _onDetect,
            errorBuilder: (context, error, _) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: Text(
                    context.l10n.cameraPermissionDenied,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                ),
              );
            },
          ),
          CustomPaint(
            size: Size.infinite,
            painter: _ScanOverlayPainter(
              color: context.colors.primary,
              scanSize: 260,
            ),
          ),
        ],
      ),
    );
  }
}

class _ScanOverlayPainter extends CustomPainter {
  final Color color;
  final double scanSize;

  _ScanOverlayPainter({required this.color, required this.scanSize});

  @override
  void paint(Canvas canvas, Size size) {
    const cornerLength = 32.0;
    const radius = 16.0;

    final left = (size.width - scanSize) / 2;
    final top = (size.height - scanSize) / 2;
    final scanRect = Rect.fromLTWH(left, top, scanSize, scanSize);
    final scanRRect =
        RRect.fromRectAndRadius(scanRect, const Radius.circular(radius));

    // Dark overlay with cutout
    final overlayPath = Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height))
      ..addRRect(scanRRect)
      ..fillType = PathFillType.evenOdd;
    canvas.drawPath(
      overlayPath,
      Paint()..color = Colors.black.withValues(alpha: 0.6),
    );

    // Corner brackets
    final cornerPaint = Paint()
      ..color = color
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final r = scanRect;

    // Top-left
    canvas.drawPath(
      Path()
        ..moveTo(r.left, r.top + cornerLength)
        ..lineTo(r.left, r.top + radius)
        ..quadraticBezierTo(r.left, r.top, r.left + radius, r.top)
        ..lineTo(r.left + cornerLength, r.top),
      cornerPaint,
    );

    // Top-right
    canvas.drawPath(
      Path()
        ..moveTo(r.right - cornerLength, r.top)
        ..lineTo(r.right - radius, r.top)
        ..quadraticBezierTo(r.right, r.top, r.right, r.top + radius)
        ..lineTo(r.right, r.top + cornerLength),
      cornerPaint,
    );

    // Bottom-left
    canvas.drawPath(
      Path()
        ..moveTo(r.left, r.bottom - cornerLength)
        ..lineTo(r.left, r.bottom - radius)
        ..quadraticBezierTo(r.left, r.bottom, r.left + radius, r.bottom)
        ..lineTo(r.left + cornerLength, r.bottom),
      cornerPaint,
    );

    // Bottom-right
    canvas.drawPath(
      Path()
        ..moveTo(r.right - cornerLength, r.bottom)
        ..lineTo(r.right - radius, r.bottom)
        ..quadraticBezierTo(r.right, r.bottom, r.right, r.bottom - radius)
        ..lineTo(r.right, r.bottom - cornerLength),
      cornerPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
