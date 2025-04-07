import 'package:auto_route/auto_route.dart';
import 'package:job_pilot/core/router/router.gr.dart';

/// This class used for defined routes and paths na dother properties
@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  late final List<AutoRoute> routes = [
    AutoRoute(
      page: NavBarRoute.page,
      path: '/nav',
      // initial: true,
      children: [
        RedirectRoute(
          path: '',
          redirectTo: 'home',
        ),
        AdaptiveRoute(
          page: HomeRoute.page,
          path: 'home',
        ),
        AdaptiveRoute(
          page: EmailSenderRoute.page,
          path: 'email_send',
        ),
        AdaptiveRoute(
          page: ProfileRoute.page,
          path: 'profile',
        ),
      ],
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
      page: LoginRoute.page,
      path: '/login',
    ),
    AutoRoute(
      page: SignUpRoute.page,
      path: '/sign-up',
    ),
    AutoRoute(
      page: EmailOnboardRoute.page,
      path: '/email-onboard',
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
    AutoRoute(
      page: BulkEmailRoute.page,
      path: '/bulk-email',
      // initial: true,
    ),
  ];
}
