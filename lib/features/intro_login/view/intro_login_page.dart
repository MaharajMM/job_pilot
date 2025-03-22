import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:job_pilot/features/intro_login/widgets/intro_page_background_wrapper.dart';
import 'package:job_pilot/features/intro_login/widgets/intro_page_body_area.dart';

@RoutePage()
class IntroLoginPage extends StatelessWidget {
  const IntroLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return IntroLoginView();
  }
}

class IntroLoginView extends StatelessWidget {
  const IntroLoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Stack(
        children: [
          IntroLoginBackground(),
          IntroPageBodyArea(),
        ],
      ),
    );
  }
}
