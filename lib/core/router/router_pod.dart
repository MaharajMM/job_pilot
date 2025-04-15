import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_pilot/core/router/router.dart';
import 'package:job_pilot/data/service/email_template/email_template_db_service_pod.dart';

/// This global variable used for global working on ui elements where
/// may be context is not present
final navigatorKey = GlobalKey<NavigatorState>();

/// This provider used for storing router
/// and can be acessed by reading it using ProviderRef/WidgetRef
final autorouterProvider = Provider.autoDispose<AppRouter>(
  (ref) => AppRouter(emailTemplateDbService: ref.watch(emailTemplateDbProvider)),
  name: 'autorouterProvider',
);
