import 'dart:math';

import 'package:flutter/material.dart';

final double root3 = sqrt(3);
final double root5 = sqrt(5);
final double phi = (1 + root5) / 2;

// geometry
// radius of triangle with side length = 1
final double faceRadius = root3 / 2 * 2 / 3;
final double faceHeight = faceRadius * 3 / 2;
final double capApothem = 0.5 / tan((pi * 2) / 10);
final double capRadius = 0.5 / sin((pi * 2) / 10);
final double capTilt = asin(capApothem / faceHeight);
final double capSagitta = capRadius - capApothem;
final double sideTilt = asin(capSagitta / faceHeight);
final double sideHeight =
    sqrt(faceHeight * faceHeight - capSagitta * capSagitta);
