import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Helpers {
  static void logc(Object o) {
    if (kDebugMode) {
      log("$o");
    }
  }

  static void log(Object o) {
    if (kDebugMode) {
      print("``````````````\n $o \n\n``````````````");
    }
  }

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

  static String parseError(dynamic exception) {
    try {
      final List<String> errorTitles = exception.message.keys.toList();
      final String error = errorTitles
          .map((e) => "${exception.message[e][0]}\n")
          .toList()
          .toString();
      return error.replaceAll(RegExp('[^A-Za-z0-9 \n]'), '');
    } catch (e) {
      return exception.toString();
    }
  }

  static Future<void> showMessage(
    BuildContext context, {
    required String message,
    String? title,
  }) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
        title: Text(
          title ?? "Notice",
        ),
        content: Text(
          message,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  static String getAsset(String file, {bool isSvg = false}) {
    final base = isSvg ? "assets/svg/" : "assets/images/";
    return base + file;
  }

}