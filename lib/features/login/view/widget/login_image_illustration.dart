import 'package:flutter/material.dart';
import 'package:job_pilot/const/resource.dart';

class LoginIllustrationImage extends StatelessWidget {
  const LoginIllustrationImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      R.ASSETS_ILLUSTRATIONS_AUTH_ILLUSTRATION_PNG,
      fit: BoxFit.contain,
    );
  }
}
