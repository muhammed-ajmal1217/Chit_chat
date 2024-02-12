import 'package:flutter/material.dart';

class GradientBorderCircleAvatar extends StatelessWidget {
  final String imageUrl;
  final double radius;
  final List<Color> gradientColors;
  final double borderWidth;

  const GradientBorderCircleAvatar({
    Key? key,
    required this.imageUrl,
    required this.radius,
    required this.gradientColors,
    this.borderWidth = 1.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          backgroundImage: AssetImage(imageUrl),
          radius: radius,
        ),
        Positioned.fill(
          child: CustomPaint(
            painter: _GradientBorderPainter(
              gradientColors: gradientColors,
              strokeWidth: borderWidth,
            ),
          ),
        ),
      ],
    );
  }
}

class _GradientBorderPainter extends CustomPainter {
  final List<Color> gradientColors;
  final double strokeWidth;

  _GradientBorderPainter({
    required this.gradientColors,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Offset.zero & Size(70, 70);

    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final Gradient gradient = LinearGradient(
      colors: gradientColors,
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

    final Path path = Path()
      ..addOval(rect.inflate(strokeWidth))
      ..fillType = PathFillType.evenOdd;

    canvas.drawPath(path, paint..shader = gradient.createShader(rect));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}