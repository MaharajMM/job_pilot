import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:job_pilot/const/colors/app_colors.dart';
import 'package:job_pilot/const/resource.dart';
import 'package:job_pilot/core/router/router.gr.dart';
import 'package:job_pilot/shared/widget/buttons/app_primary_btn.dart';
import 'package:job_pilot/shared/widget/custom_text_formfield.dart';
import 'package:job_pilot/shared/widget/dot_widget.dart';
import 'package:velocity_x/velocity_x.dart';

class AuthForm extends StatefulWidget {
  final FocusNode? nameFocusNode;
  final FocusNode? emailFocusNode;
  final FocusNode? passwordFocusNode;
  final bool isSignUp;
  final Widget authBtn;
  const AuthForm({
    super.key,
    this.nameFocusNode,
    this.emailFocusNode,
    this.passwordFocusNode,
    this.isSignUp = false,
    required this.authBtn,
  });

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Name Field
        if (widget.isSignUp)
          CustomTextFormField(
            name: 'name',
            focusNode: widget.nameFocusNode,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            labelText: 'Name',
            prefixIcon: Icon(Icons.person, color: AppColors.grey800),
            validator: FormBuilderValidators.compose(
              [
                FormBuilderValidators.required(),
              ],
            ),
          ),
        20.heightBox,
        // Email Field
        CustomTextFormField(
          name: 'Email',
          focusNode: widget.emailFocusNode,
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
        CustomTextFormField(
          name: 'password',
          labelText: 'Password',
          focusNode: widget.passwordFocusNode,
          textInputAction: TextInputAction.next,
          isObscureText: _obscureText,
          prefixIcon: Icon(Icons.lock, color: AppColors.grey800),
          suffixIcon: IconButton(
            icon: Icon(
              _obscureText ? Icons.visibility : Icons.visibility_off,
              color: AppColors.grey800,
            ),
            onPressed: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
          ),
          maxLine: 1,
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(),
            FormBuilderValidators.minLength(6),
          ]),
        ),
        if (widget.isSignUp) 20.heightBox else 0.heightBox,
        if (widget.isSignUp)
          CustomTextFormField(
            name: 'confirm_password',
            labelText: 'Confirm Password',
            isObscureText: _obscureText,
            prefixIcon: Icon(Icons.password, color: AppColors.grey800),
            suffixIcon: IconButton(
              icon: Icon(
                _obscureText ? Icons.visibility : Icons.visibility_off,
                color: AppColors.grey800,
              ),
              onPressed: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
            ),
            maxLine: 1,
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(),
              FormBuilderValidators.minLength(6),
            ]),
          ),
        12.heightBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () => context.navigateTo(
                ForgotPasswordBaseRoute(),
              ),
              child: Text('Forgot Password?'),
            ),
          ],
        ),
        12.heightBox,
        widget.authBtn,
        20.heightBox,
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            DotWidget(
              dashHeight: 1,
              dashWidth: 5,
              totalWidth: 150,
            ),
            Text('Or').pSymmetric(h: 8),
            DotWidget(
              dashHeight: 1,
              dashWidth: 5,
              totalWidth: 150,
            ),
          ],
        ),
        20.heightBox,
        PrimaryButton(
          isIcon: true,
          icon: Image.asset(
            R.ASSETS_IMAGES_GOOGLE_LOGO_PNG,
            height: 30,
          ),
          color: AppColors.kPrimaryBgColor,
          fontColor: AppColors.kPrimaryColor,
          labelText: widget.isSignUp ? 'Sign up with Google' : 'Login with Google',
          onPressed: () {},
        ),
      ],
    );
  }
}
