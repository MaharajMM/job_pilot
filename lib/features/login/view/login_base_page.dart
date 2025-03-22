import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage(
  deferredLoading: true,
)
class LoginBasePage extends StatelessWidget {
  const LoginBasePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoRouter();

    // Scaffold(
    //   // backgroundColor: AppColors.blue100,
    //   extendBodyBehindAppBar: true,
    //   body: SafeArea(
    //     bottom: false,
    //     child: SingleChildScrollView(
    //       physics: const BouncingScrollPhysics(),
    //       child: Column(
    //         children: [
    //           Stack(
    //             children: [
    //               SlideAnimationBuilder(
    //                 delay: Durations.short3,
    //                 child: const LoginIllustrationImage().objectTopCenter().h(350),
    //               ),
    //               Positioned(
    //                 top: 0,
    //                 right: 15,
    //                 child: SignUpBtn(),
    //               ),
    //             ],
    //           ),
    //           const AutoRouter().h(context.screenHeight * 0.6),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}
