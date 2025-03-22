import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:job_pilot/core/router/router.gr.dart';
import 'package:job_pilot/features/verify_otp/view/widget/otp_form.dart';
import 'package:job_pilot/shared/widget/animations/slide_animation_builder.dart';
import 'package:job_pilot/shared/widget/buttons/app_primary_btn.dart';
import 'package:velocity_x/velocity_x.dart';

@RoutePage()
class VerifyOtpPage extends StatelessWidget {
  const VerifyOtpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return VerifyOtpView();
  }
}

class VerifyOtpView extends StatefulWidget {
  const VerifyOtpView({super.key});

  @override
  State<VerifyOtpView> createState() => _VerifyOtpViewState();
}

class _VerifyOtpViewState extends State<VerifyOtpView> {
  final TextEditingController _otpController = TextEditingController();

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: SlideAnimationBuilder(
        delay: Durations.short3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Enter Verification Code',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            Text('We have sent a code to maharajmm@gmail.com'),
            20.heightBox,
            Center(child: OtpForm(otpController: _otpController).pSymmetric(v: 30)),
            Center(
              child: const Text(
                "Didn't get the otp ?",
              ),
            ),
            // OtpTimer(phoneNumber: 'maharajmm@gmail.com').pOnly(top: 10, bottom: 20),
            20.heightBox,
            PrimaryButton(
              labelText: 'Continue',
              onPressed: () {
                context.navigateTo(ConfirmPasswordRoute());
              },
            ),
          ],
        ),
      ),
    );
  }
}
