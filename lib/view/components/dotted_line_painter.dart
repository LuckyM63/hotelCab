import 'package:flutter/material.dart';

import '../../../core/utils/my_color.dart';

class DottedLinePainter extends CustomPainter {

  final double width;
  final double spacing;
  final Color color;
  DottedLinePainter({required this.width, required this.spacing, required this.color});
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color // Adjust the color of the dots
      ..strokeWidth = 1.0 // Adjust the width of the dots
      ..style = PaintingStyle.stroke;

    double length = 0;

    while (length < size.width) {
      canvas.drawLine(Offset(length, 0), Offset(length+spacing, 0), paint);
      length += 2 * spacing; //adjust the single dot length
    }
  }

  @override
  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}