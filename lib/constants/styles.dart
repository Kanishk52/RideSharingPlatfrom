import 'package:flutter/material.dart';

class AppStyles {
  static const pagePadding = EdgeInsets.all(24.0);

  static const headingStyle = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    letterSpacing: -0.5,
    height: 1.2,
  );

  static const subheadingStyle = TextStyle(
    fontSize: 16,
    color: Color(0xFF6B7280),
    height: 1.5,
  );

  static BoxDecoration gradientDecoration = BoxDecoration(
    gradient: LinearGradient(
      colors: [
        const Color(0xFF7C3AED).withOpacity(0.05),
        const Color(0xFF2DD4BF).withOpacity(0.05),
      ],
    ),
  );

  static const cardSpacing = SizedBox(height: 16);

  static BoxDecoration iconBoxDecoration = BoxDecoration(
    color: const Color(0xFF7C3AED).withOpacity(0.1),
    borderRadius: BorderRadius.circular(12),
  );
}
