import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget tablet;

  const Responsive({super.key, required this.mobile, required this.tablet});

  // screen sizes
  static bool isSmallMobile(BuildContext context) =>
      MediaQuery.of(context).size.width <= 390;

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width <= 700;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width <= 1024 &&
      MediaQuery.of(context).size.width >= 800;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width > 1024;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    if (width <= 1280 && width >= 800) {
      return tablet;
    } else {
      return mobile;
    }
  }
}
