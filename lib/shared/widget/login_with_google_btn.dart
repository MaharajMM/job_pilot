import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:job_pilot/const/colors/app_colors.dart';
import 'package:job_pilot/const/resource.dart';
import 'package:job_pilot/core/router/router.gr.dart';
import 'package:job_pilot/features/email_sender/auth_api.dart';
import 'package:job_pilot/shared/widget/buttons/app_primary_btn.dart';

class LoginWithGoogleBtn extends StatelessWidget {
  final bool isSignUp;
  const LoginWithGoogleBtn({
    super.key,
    required this.isSignUp,
  });

  @override
  Widget build(BuildContext context) {
    return PrimaryButton(
      isIcon: true,
      icon: Image.asset(
        R.ASSETS_IMAGES_GOOGLE_LOGO_PNG,
        height: 30,
      ),
      color: AppColors.kPrimaryBgColor,
      fontColor: AppColors.kPrimaryColor,
      labelText: isSignUp ? 'Sign up with Google' : 'Login with Google',
      onPressed: () async {
        await GoogleAuthApi.signOut();
        final user = await GoogleAuthApi.signIn();
        if (user == null) return;
        final GoogleSignInAuthentication gAuth = await user.authentication;
        final credential = GoogleAuthProvider.credential(
          accessToken: gAuth.accessToken,
          idToken: gAuth.idToken,
        );
        await FirebaseAuth.instance.signInWithCredential(credential);
        if (context.mounted) {
          context.router.replace(EmailOnboardRoute());
        }
      },
    );
  }
}
