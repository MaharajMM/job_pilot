import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:job_pilot/const/colors/app_colors.dart';
import 'package:job_pilot/core/router/router.gr.dart';
import 'package:pinput/pinput.dart';

class OtpForm extends StatefulWidget {
  final TextEditingController otpController;
  const OtpForm({super.key, required this.otpController});

  @override
  State<OtpForm> createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> {
  final defaultPinTheme = PinTheme(
    width: 50,
    height: 50,
    textStyle: const TextStyle(
      fontSize: 18,
      color: AppColors.kBlack,
      fontWeight: FontWeight.w600,
    ),
    decoration: BoxDecoration(
      border: Border.all(color: AppColors.kPrimaryColor),
      borderRadius: BorderRadius.circular(5),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final submittedPinTheme = defaultPinTheme;
    final focusedPinTheme = defaultPinTheme;

    return Pinput(
      length: 6,
      // closeKeyboardWhenCompleted: true,
      enableSuggestions: true,
      controller: widget.otpController,
      defaultPinTheme: defaultPinTheme,
      focusedPinTheme: focusedPinTheme,
      submittedPinTheme: submittedPinTheme,
      hapticFeedbackType: HapticFeedbackType.mediumImpact,
      validator: (s) {
        return s == '222222' ? null : 'Pin is incorrect';
      },
      pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
      showCursor: true,
      onCompleted: (pin) => context.navigateTo(ConfirmPasswordRoute()),
      keyboardType: TextInputType.number,
    );
  }
}
