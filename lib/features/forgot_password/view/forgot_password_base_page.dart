import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:job_pilot/const/resource.dart';

import 'package:velocity_x/velocity_x.dart';

@RoutePage()
class ForgotPasswordBasePage extends StatelessWidget {
  const ForgotPasswordBasePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            SvgPicture.asset(
              R.ASSETS_ILLUSTRATIONS_FORGOT_PASSWORD_SVG,
              fit: BoxFit.contain,
              height: 300,
              // height: Responsive.isTablet(context) ? 400 : null,
            ).objectTopCenter(),
            const AutoRouter(),
          ],
        ).scrollVertical(),
      ),
    );
  }
}
