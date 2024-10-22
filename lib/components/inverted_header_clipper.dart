// Clipper personalizado para crear el borde curvado inverso en el encabezado
import 'dart:ui';

import 'package:flutter/material.dart';

class InvertedHeaderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 30); 

    var controlPoint = Offset(size.width / 2, size.height); 
    var endPoint = Offset(size.width, size.height - 30); 

    // Curva inversa de Bezier
    path.quadraticBezierTo(controlPoint.dx, controlPoint.dy, endPoint.dx, endPoint.dy);
    path.lineTo(size.width, 0); 
    path.close(); 
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
