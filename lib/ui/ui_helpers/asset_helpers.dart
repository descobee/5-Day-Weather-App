import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UiHelpers {

  static Widget getSvg(
    String path, {
    Color? color,
    double? height,
    double? width,
    BoxFit? fit,
  }) {
    return SvgPicture.asset(
      path,
      color: color,
      height: height,
      width: width,
      fit: fit ?? BoxFit.contain,
    );
  }
}

class AppImage extends StatelessWidget {
  final String path;
  final double? width;
  final double? height;
  final BoxFit? boxFit;
  const AppImage({
    super.key,
    required this.path,
    this.width,
    this.height,
    this.boxFit,
  });

  @override
  Widget build(BuildContext context) {
      return Image(
        image: AssetImage(path),
        fit: boxFit ?? BoxFit.contain,
        height: height,
        width: width,
      );
  }
}