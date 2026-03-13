import 'package:flutter/material.dart';

abstract class AppColors {
  // 🌍 Base Colors
  static const Color whiteColor = Colors.white;
  static const Color blackColor = Colors.black;

  // 🎓 Primary Branding
  static const Color primaryBlue = Color(0xFF1565C0);
  static const Color secondaryBlue = Color(0xFF1E88E5);
  static const Color lightBlue = Color(0xFFE3F2FD);

  // 🖥 Background
  static const Color scaffoldBackground = Color(0xFFF5F7FA);
  static const Color cardBackground = Color(0xFFFFFFFF);

  // ✍ Text Colors
  static const Color primaryText = Color(0xFF1A1A1A);
  static const Color secondaryText = Color(0xFF6C757D);
  static const Color hintText = Color(0xFFB0BEC5);
  static const Color hintText2 = Color(0xFF334155);

  // 🚦 Status Colors
  static const Color successColor = Color(0xFF28C76F);
  static const Color errorColor = Color(0xFFFF4C51);
  static const Color warningColor = Color(0xFFFFC107);

  // 🧱 Borders & Dividers
  static const Color borderColor = Color(0xFFE0E0E0);
  static const Color dividerColor = Color(0xFFEEEEEE);

  // 🎥 Video / Course Accent
  static const Color purpleAccent = Color(0xFF7367F0);

  // 🌈 Custom Colors
  static const Color color1 = Color(0xFF334155);
  static const Color color2 = Color(0xFF64748B);
  static const Color color3 = Color(0xFF94A3B8);
  static const Color color4 = Color(0xFF64748B);
  static const Color gradientStart = Color(0xFFE53935);
  static const Color gradientEnd = Color(0xFFFF7043);

  // 🌟 Gradient Example
  static LinearGradient customGradient = LinearGradient(
    colors: [gradientStart, gradientEnd],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}