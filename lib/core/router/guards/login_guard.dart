import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:job_pilot/core/router/router.gr.dart';

class LoginGuard extends AutoRouteGuard {
  @override

  /// A class that provides database services for token management.
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    if (user != null) {
      resolver.next(true);
    } else {
      router.replaceAll([const IntroLoginRoute()]);
      resolver.next(false);
    }
  }
}
