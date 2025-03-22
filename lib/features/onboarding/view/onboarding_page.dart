import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:job_pilot/const/app_defaults.dart';
import 'package:job_pilot/const/colors/app_colors.dart';
import 'package:job_pilot/core/router/router.gr.dart';
import 'package:job_pilot/shared/widget/animations/slide_animation_builder.dart';

import '../data/model/onboarding_model.dart';
import '../data/onboarding_data.dart';
import 'widgets/onboarding_widget.dart';

@RoutePage()
class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return OnboardingView();
  }
}

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  int currentPage = 0;
  late PageController controller;
  List<OnboardingModel> items = OnboardingData.items;

  onPageChange(int value) {
    currentPage = value;
    setState(() {});
  }

  _gotoNextPage() {
    if (currentPage < items.length - 1) {
      controller.nextPage(
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOutCubic,
      );
    } else {
      _gotoLoginSignUp();
    }
  }

  _gotoLoginSignUp() {
    context.navigateTo(IntroLoginRoute());
  }

  @override
  void initState() {
    super.initState();
    controller = PageController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kwhite,
      appBar: AppBar(
        backgroundColor: AppColors.kPrimaryColor,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // const Spacer(),
            Expanded(
              flex: 8,
              child: PageView.builder(
                onPageChanged: onPageChange,
                itemCount: items.length,
                controller: controller,
                physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                itemBuilder: (context, index) {
                  return OnboardingWidget(data: items[index]);
                },
              ),
            ),
            // const Spacer(),
            SlideAnimationBuilder(
              delay: const Duration(milliseconds: 500),
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  TweenAnimationBuilder(
                    duration: Duration(milliseconds: 500),
                    tween: Tween<double>(begin: 0, end: (1 / items.length) * (currentPage + 1)),
                    curve: Curves.easeInOutBack,
                    builder: (context, double value, _) => SizedBox(
                      height: 70,
                      width: 70,
                      child: CircularProgressIndicator(
                        value: value,
                        strokeWidth: 6,
                        backgroundColor: AppColors.green100,
                        color: AppColors.kPrimaryColor,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _gotoNextPage,
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      backgroundColor: AppColors.kPrimaryBgColor,
                    ),
                    child: Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: AppColors.kPrimaryColor,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppDefaults.padding),
          ],
        ),
      ),
    );
  }
}
