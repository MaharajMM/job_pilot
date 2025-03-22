import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_pilot/const/colors/app_colors.dart';

import 'package:velocity_x/velocity_x.dart';

class OtpTimer extends ConsumerStatefulWidget {
  final String phoneNumber;
  const OtpTimer({super.key, required this.phoneNumber});

  @override
  ConsumerState<OtpTimer> createState() => _OtpTimerState();
}

class _OtpTimerState extends ConsumerState<OtpTimer> {
  final interval = const Duration(seconds: 1);
  bool isResendAvailable = false;
  final int timerMaxSeconds = 60;
  late Timer timer;
  int currentSeconds = 0;

  String get timerText =>
      '${((timerMaxSeconds - currentSeconds) ~/ 60).toString().padLeft(2, '0')}: ${((timerMaxSeconds - currentSeconds) % 60).toString().padLeft(2, '0')}';

  startTimeout([int? milliseconds]) {
    var duration = interval;
    timer = Timer.periodic(duration, (timer) {
      // it specifies that if the widget state is not the widget tree then return nothing
      if (!mounted) return;
      setState(() {
        currentSeconds = timer.tick;
        if (timer.tick >= timerMaxSeconds) {
          setState(() {
            isResendAvailable = true;
          });
          timer.cancel();
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    startTimeout();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return isResendAvailable
        ? GestureDetector(
            onTap: () {},
            child: const Center(
              child: Text(
                'Resend OTP',
                style: TextStyle(
                  color: AppColors.kPrimaryColor,
                ),
              ),
            ),
          )
        : Center(
            child: AnimatedDefaultTextStyle(
              duration: 300.milliseconds,
              style: timer.isActive ? const TextStyle(fontSize: 16) : const TextStyle(fontSize: 0),
              child: 'Retry in $timerText'.text.color(AppColors.kPrimaryColor).make(),
            ),
          );
  }
}
