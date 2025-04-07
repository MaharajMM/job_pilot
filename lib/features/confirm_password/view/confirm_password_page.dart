import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:job_pilot/const/colors/app_colors.dart';
import 'package:job_pilot/shared/widget/animations/slide_animation_builder.dart';
import 'package:job_pilot/shared/widget/buttons/app_primary_btn.dart';
import 'package:job_pilot/shared/widget/custom_text_formfield.dart';
import 'package:velocity_x/velocity_x.dart';

@RoutePage()
class ConfirmPasswordPage extends StatelessWidget {
  const ConfirmPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ConfirmPasswordView();
  }
}

class ConfirmPasswordView extends StatefulWidget {
  const ConfirmPasswordView({super.key});

  @override
  State<ConfirmPasswordView> createState() => _ConfirmPasswordViewState();
}

class _ConfirmPasswordViewState extends State<ConfirmPasswordView> {
  bool _obscureText1 = true;
  bool _obscureText2 = true;
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
              'Reset Your Passowrd!',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            Text('The password must be different than before.'),
            40.heightBox,
            FormBuilder(
              child: Column(
                children: [
                  CustomTextFormField(
                    name: 'password',
                    labelText: 'Password',
                    textInputAction: TextInputAction.next,
                    isObscureText: _obscureText1,
                    prefixIcon: Icon(Icons.lock, color: AppColors.grey800),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureText1 ? Icons.visibility : Icons.visibility_off,
                        color: AppColors.grey800,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText1 = !_obscureText1;
                        });
                      },
                    ),
                    maxLine: 1,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.minLength(6),
                    ]),
                  ),
                  20.heightBox,
                  CustomTextFormField(
                    name: 'confirm_password',
                    labelText: 'Confirm Password',
                    isObscureText: _obscureText2,
                    prefixIcon: Icon(Icons.password, color: AppColors.grey800),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureText2 ? Icons.visibility : Icons.visibility_off,
                        color: AppColors.grey800,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText2 = !_obscureText2;
                        });
                      },
                    ),
                    maxLine: 1,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.minLength(6),
                    ]),
                  ),
                  20.heightBox,
                  PrimaryButton(
                    labelText: 'Confirm',
                    onPressed: () {
                      // context.router.replace(LoginRoute());
                      context.maybePop();
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
