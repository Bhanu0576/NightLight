import 'package:flutter/material.dart';

class DotteLine extends StatelessWidget {
  final Color linecolor;
  const DotteLine({Key? key, required this.linecolor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomPaint(painter: DrawDottedhorizontalline(linecolor)),
    );
  }
}

class DrawDottedhorizontalline extends CustomPainter {
  Paint? _paint;
  DrawDottedhorizontalline(Color li) {
    _paint = Paint();
    _paint?.color = li; //dots color
    _paint?.strokeWidth = 0.5; //dots thickness
    _paint?.strokeCap = StrokeCap.square; //dots corner edges
  }

  @override
  void paint(Canvas canvas, Size size) {
    for (double i = -160; i < 160; i = i + 15) {
      // 15 is space between dots
      if (i % 1 == 0) canvas.drawLine(Offset(i, 0.0), Offset(i + 10, 0.0), _paint!);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
