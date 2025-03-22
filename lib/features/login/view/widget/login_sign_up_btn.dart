import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:job_pilot/const/colors/app_colors.dart';
import 'package:job_pilot/core/router/router.gr.dart';

class LoginSignUpBtn extends StatelessWidget {
  final bool isLogin;
  const LoginSignUpBtn({
    super.key,
    this.isLogin = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        isLogin ? context.router.replace(LoginRoute()) : context.router.replace(SignUpRoute());
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.kPrimaryColor,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          children: [
            Text(
              isLogin ? 'Login' : 'Sign Up',
              style: TextStyle(
                fontSize: 14,
              ),
            ),
            Icon(
              Icons.keyboard_arrow_right_outlined,
              color: AppColors.kPrimaryBgColor,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
