import 'package:fifthlab_assessment/core/constants/app_strings.dart';
import 'package:fifthlab_assessment/ui/shared_widgets/spacing_widgets.dart';
import 'package:flutter/material.dart';

class CustomDialog {
  static customDialog(
      BuildContext context, VoidCallback function, String message) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              buttonPadding: EdgeInsets.zero,
              contentPadding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              content: SizedBox(
                width: screenWidth(context, percent: 0.9),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    YMargin(screenHeight(context, percent: 0.02)),
                    const Text(AppStrings.alert,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        message,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    YMargin(screenHeight(context, percent: 0.03)),
                  ],
                ),
              ),
              actions: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: function,
                          child: const Text(
                            AppStrings.retry,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            AppStrings.cancel,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ));
  }
}
