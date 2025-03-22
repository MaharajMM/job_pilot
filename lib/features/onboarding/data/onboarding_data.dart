import 'package:job_pilot/const/resource.dart';

import 'model/onboarding_model.dart';

class OnboardingData {
  static List<OnboardingModel> items = [
    OnboardingModel(
      imageUrl: R.ASSETS_ILLUSTRATIONS_EMAIL_SERVICE_SVG,
      headline: 'Effortless Job Applications',
      description:
          'Send multiple job applications with a single click. Save time and increase your chances of getting hired!',
    ),
    OnboardingModel(
      imageUrl: R.ASSETS_ILLUSTRATIONS_EMAIL_MANAGEMENT_SVG,
      headline: 'Smart Email Management',
      description:
          'Store your email templates and attachments for quick access. Customize before sending or use saved details.',
    ),
    OnboardingModel(
      imageUrl: R.ASSETS_ILLUSTRATIONS_EMAIL_TRACK_SVG,
      headline: 'Track Your Applications',
      description:
          'See which companies you’ve applied to, view your email history, and analyze your job search progress with insights.',
    ),
  ];
}

//407BFF