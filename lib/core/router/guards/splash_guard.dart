import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:job_pilot/core/router/router.gr.dart';

class SplashGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    // final isOnboarding = onboardingDbService.getOnboardingStatus();

    if (user != null) {
      router.replaceAll([const EmailOnboardRoute()]);

      resolver.next(false);
    }
    //  else if (isOnboarding == false) {
    //   router.replaceAll([const OnboardingRoute()]);
    //   resolver.next(false);
    // }
    else {
      router.replaceAll([const IntroLoginRoute()]);
      resolver.next(true);
    }
  }
}
