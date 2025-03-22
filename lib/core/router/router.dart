import 'package:auto_route/auto_route.dart';
import 'package:job_pilot/core/router/router.gr.dart';

/// This class used for defined routes and paths na dother properties
@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  late final List<AutoRoute> routes = [
    AutoRoute(
      page: EmailSenderRoute.page,
      path: '/email_sender',
      // path: '/',
      // initial: true,
    ),
    AutoRoute(
      page: OnboardingRoute.page,
      path: '/',
      initial: true,
    ),
    AutoRoute(
      page: IntroLoginRoute.page,
      path: '/intro-login',
      // path: '/',
    ),
    AutoRoute(
      page: HomeRoute.page,
      path: '/home',
      // initial: true,
    ),
    AutoRoute(
      page: LoginRoute.page,
      path: '/login',
      // initial: true,
    ),
    AutoRoute(
      page: SignUpRoute.page,
      path: '/sign-up',
      // initial: true,
    ),
    AutoRoute(
      page: ForgotPasswordBaseRoute.page,
      path: '/forgot-password-base',
      // path: '/',
      // initial: true,
      children: [
        RedirectRoute(
          path: '',
          redirectTo: 'forgot-password',
        ),
        AutoRoute(
          page: ForgotPasswordRoute.page,
          path: 'forgot-password',
        ),
        AutoRoute(
          page: VerifyOtpRoute.page,
          path: 'verify-otp',
        ),
        AutoRoute(
          page: ConfirmPasswordRoute.page,
          path: 'confirm-password',
        ),
      ],
    ),
  ];
}
