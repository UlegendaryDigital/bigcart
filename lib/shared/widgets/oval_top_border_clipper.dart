import 'package:flutter/widgets.dart';

/// Clips a rectangle whose top edge is a smooth oval curve.
///
/// The curve starts at (0, [curveHeight]), rises to (width/2, 0),
/// and ends at (width, [curveHeight]).
class OvalTopBorderClipper extends CustomClipper<Path> {
  const OvalTopBorderClipper({this.curveHeight = 44});

  final double curveHeight;

  @override
  Path getClip(Size size) {
    final h = curveHeight.clamp(0.0, size.height).toDouble();

    return Path()
      ..moveTo(0, h)
      ..quadraticBezierTo(size.width / 2, 0, size.width, h)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
  }

  @override
  bool shouldReclip(covariant OvalTopBorderClipper oldClipper) =>
      oldClipper.curveHeight != curveHeight;
}

