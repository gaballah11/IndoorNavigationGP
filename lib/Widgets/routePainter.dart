import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gp/Modules/accessPoint.dart';
import 'dart:ui' as ui;

import 'package:gp/Modules/place.dart';
import 'package:gp/screens/homescreen.dart';

class RoutePainter extends CustomPainter{

  List<coordinates> routeCoord = [];

  RoutePainter(this.routeCoord);

  @override
  void paint(Canvas canvas, Size size) {
    final pointMode = ui.PointMode.polygon;
    final points = routeCoord.map((e) => Offset((e.x/950)*368,(e.y/1550)*620)).toList();

    final paint = Paint()
      ..color = Colors.redAccent
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round;
    canvas.drawPoints(pointMode, points, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }

}

