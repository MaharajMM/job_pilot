import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:job_pilot/const/colors/app_colors.dart';
import 'package:job_pilot/core/router/router.gr.dart';
import 'package:job_pilot/shared/widget/animations/slide_animation_builder.dart';
import 'package:job_pilot/shared/widget/buttons/app_primary_btn.dart';
import 'package:job_pilot/shared/widget/custom_text_formfield.dart';
import 'package:velocity_x/velocity_x.dart';

@RoutePage()
class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ForgotPasswordView();
  }
}

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({super.key});

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
              'Forgot Passowrd!',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            Text('Enter your email to resent password'),
            40.heightBox,
            FormBuilder(
              child: Column(
                children: [
                  CustomTextFormField(
                    name: 'Email',
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email, color: AppColors.grey800),
                    validator: FormBuilderValidators.compose(
                      [
                        FormBuilderValidators.required(),
                        FormBuilderValidators.email(),
                      ],
                    ),
                  ),
                  20.heightBox,
                  PrimaryButton(
                    labelText: 'Continue',
                    onPressed: () {
                      context.navigateTo(VerifyOtpRoute());
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
