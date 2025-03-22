import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:job_pilot/const/app_defaults.dart';
import 'package:job_pilot/const/colors/app_colors.dart';
import 'package:job_pilot/shared/widget/animations/slide_animation_builder.dart';

import '../../data/model/onboarding_model.dart';

class OnboardingWidget extends StatelessWidget {
  const OnboardingWidget({
    super.key,
    required this.data,
  });

  final OnboardingModel data;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              color: AppColors.kPrimaryColor,
            ),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppDefaults.padding * 2),
              child: SvgPicture.asset(
                data.imageUrl,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SlideAnimationBuilder(
                delay: const Duration(milliseconds: 250),
                child: Text(
                  data.headline,
                  style:
                      Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(AppDefaults.padding),
                child: SlideAnimationBuilder(
                  delay: const Duration(milliseconds: 400),
                  child: Text(
                    data.description,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
