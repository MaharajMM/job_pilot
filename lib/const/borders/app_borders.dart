import 'package:flutter/material.dart';

class AppBorder {
  AppBorder._();
  // All Circular Radius Constant
  static BorderRadiusGeometry kQuatCurve = BorderRadius.circular(5);
  static BorderRadiusGeometry kHalfCurve = BorderRadius.circular(10);
  static BorderRadiusGeometry kHalfMiddleCurve = BorderRadius.circular(15);
  static BorderRadiusGeometry kFullCurve = BorderRadius.circular(20);
  static BorderRadiusGeometry kFullMiddleCurve = BorderRadius.circular(25);

// Horizontal Circular Radius Constant
  static const BorderRadiusGeometry kHalfCurveHorizontalLeft =
      BorderRadius.horizontal(left: Radius.circular(10));
  static const BorderRadiusGeometry kHalfCurveHorizontalRight =
      BorderRadius.horizontal(right: Radius.circular(10));

// Vertical Circular Radius Constant
  static const BorderRadiusGeometry kHalfCurveVerticalTop =
      BorderRadius.vertical(top: Radius.circular(10));
  static const BorderRadiusGeometry kHalfCurveVerticalBottom =
      BorderRadius.vertical(bottom: Radius.circular(10));
}
