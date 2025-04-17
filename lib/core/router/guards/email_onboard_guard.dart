import 'package:auto_route/auto_route.dart';
import 'package:job_pilot/bootstrap.dart';
import 'package:job_pilot/core/router/router.gr.dart';
import 'package:job_pilot/data/service/email_template/email_template_db_service.dart';

class EmailOnboardGuard extends AutoRouteGuard {
  final EmailTemplateDbService emailTemplateDbService;
  EmailOnboardGuard({
    required this.emailTemplateDbService,
  });
  @override

  /// A class that provides database services for token management.
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    final savedEmailTemplate = emailTemplateDbService.getEmailTemplate();
    talker.debug('ccccccdcdcdcdcd');

    if (savedEmailTemplate == null) {
      resolver.next(true);
    } else {
      router.replaceAll([const HomeRoute()]);
      resolver.next(false);
    }
  }
}
