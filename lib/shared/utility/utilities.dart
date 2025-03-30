import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/material.dart';
import 'package:job_pilot/const/colors/app_colors.dart';

class Utilities {
  static void flushBarErrorMessage(
      {required String message, required BuildContext context, Widget? mainButton}) {
    showFlushbar(
      context: context,
      flushbar: Flushbar(
        forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        padding: const EdgeInsets.all(15),
        message: message,
        duration: const Duration(seconds: 3),
        borderRadius: BorderRadius.circular(8),
        flushbarPosition: FlushbarPosition.TOP,
        backgroundColor: AppColors.kErrorColor,
        reverseAnimationCurve: Curves.fastOutSlowIn,
        positionOffset: 20,
        icon: const Icon(
          Icons.error,
          size: 28,
          color: Colors.white,
        ),
        mainButton: mainButton,
      )..show(context),
    );
  }

  static void flushBarSuccessMessage(String message, BuildContext context) {
    showFlushbar(
      context: context,
      flushbar: Flushbar(
        forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        padding: const EdgeInsets.all(15),
        message: message,
        duration: const Duration(seconds: 3),
        borderRadius: BorderRadius.circular(8),
        flushbarPosition: FlushbarPosition.TOP,
        backgroundColor: AppColors.kSuccessColor,
        reverseAnimationCurve: Curves.fastOutSlowIn,
        positionOffset: 20,
        icon: const Icon(
          Icons.done,
          size: 28,
          color: Colors.white,
        ),
      )..show(context),
    );
  }
}
