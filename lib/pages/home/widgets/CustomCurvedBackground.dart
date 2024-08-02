import "package:flutter/material.dart";
import "package:flutter/widgets.dart";

class CustomCurvedBackground extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height);

    final firstCurvePoint1 = Offset(0, size.height - 20);
    final firstCurvePoint2 = Offset(30, size.height - 20);
    path.quadraticBezierTo(firstCurvePoint1.dx, firstCurvePoint1.dy,
        firstCurvePoint2.dx, firstCurvePoint2.dy);

    final secondCurvePoint1 = Offset(0, size.height - 20);
    final secondCurvePoint2 = Offset(size.width - 30, size.height - 20);
    path.quadraticBezierTo(secondCurvePoint1.dx, secondCurvePoint1.dy,
        secondCurvePoint2.dx, secondCurvePoint2.dy);

    final thirdCurvePoint1 = Offset(size.width, size.height - 20);
    final thirdCurvePoint2 = Offset(size.width, size.height);
    path.quadraticBezierTo(thirdCurvePoint1.dx, thirdCurvePoint1.dy,
        thirdCurvePoint2.dx, thirdCurvePoint2.dy);

    path.lineTo(size.width, 0);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
