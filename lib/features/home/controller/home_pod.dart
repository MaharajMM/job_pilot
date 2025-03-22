import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_pilot/data/service/email_template/email_template_db_service_pod.dart';
import 'package:job_pilot/features/home/controller/analytics_service.dart';

final analyticsServiceProvider = Provider<AnalyticsService>((ref) {
  return AnalyticsService();
});

// Analytics providers
final weeklyChartDataProvider = Provider<List<Map<String, dynamic>>>((ref) {
  final analyticsService = ref.watch(analyticsServiceProvider);
  final sentEmails = ref.watch(emailTemplateDbProvider).getSentEmails();
  return analyticsService.getWeeklyChartData(sentEmails);
});

final companyApplicationCountsProvider = Provider<Map<String, int>>((ref) {
  final analyticsService = ref.watch(analyticsServiceProvider);
  final sentEmails = ref.watch(emailTemplateDbProvider).getSentEmails();
  return analyticsService.getCompanyApplicationCounts(sentEmails);
});
final totalApplicationCountProvider = Provider<int>((ref) {
  final analyticsService = ref.watch(analyticsServiceProvider);
  final sentEmails = ref.watch(emailTemplateDbProvider).getSentEmails();
  return analyticsService.getTotalApplicationCount(sentEmails);
});

final uniqueCompanyCountProvider = Provider<int>((ref) {
  final analyticsService = ref.watch(analyticsServiceProvider);
  final sentEmails = ref.watch(emailTemplateDbProvider).getSentEmails();
  return analyticsService.getUniqueCompanyCount(sentEmails);
});
