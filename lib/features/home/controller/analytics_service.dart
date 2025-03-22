import 'package:intl/intl.dart';
import 'package:job_pilot/data/models/sent_email_model.dart';

class AnalyticsService {
  // Analyze email frequency by day
  Map<String, int> getEmailCountByDay(List<SentEmail> emails) {
    Map<String, int> countByDay = {};
    for (var email in emails) {
      final dateStr = DateFormat('yyyy-MM-dd').format(email.dateSent);
      countByDay[dateStr] = (countByDay[dateStr] ?? 0) + 1;
    }
    return countByDay;
  }

  // Get recipient count for each sent email
  List<int> getRecipientCountPerEmail(List<SentEmail> emails) {
    return emails.map((email) => email.recipients.length).toList();
  }

  // Extract companies from email domains
  Map<String, int> getCompanyApplicationCounts(List<SentEmail> emails) {
    Map<String, int> companyCount = {};
    for (var email in emails) {
      final domains = email.getCompanyDomains();
      for (var domain in domains) {
        companyCount[domain] = (companyCount[domain] ?? 0) + 1;
      }
    }
    return companyCount;
  }

  // Get the total number of unique companies applied to
  int getUniqueCompanyCount(List<SentEmail> emails) {
    Set<String> uniqueDomains = {};
    for (var email in emails) {
      uniqueDomains.addAll(email.getCompanyDomains());
    }
    return uniqueDomains.length;
  }

  // Get total applications sent
  int getTotalApplicationCount(List<SentEmail> emails) {
    return emails.fold<int>(0, (sum, email) => sum + email.recipients.length);
  }

  // Get chart data for the last 7 days
  List<Map<String, dynamic>> getWeeklyChartData(List<SentEmail> emails) {
    final now = DateTime.now();
    final sevenDaysAgo = now.subtract(const Duration(days: 7));

    // Filter emails from the last 7 days
    final recentEmails = emails
        .where((email) =>
            email.dateSent.isAfter(sevenDaysAgo) &&
            email.dateSent.isBefore(now.add(const Duration(days: 1))))
        .toList();

    // Generate dates for the last 7 days
    List<DateTime> dates = [];
    for (int i = 0; i < 7; i++) {
      dates.add(now.subtract(Duration(days: 6 - i)));
    }

    // Count emails per day
    List<Map<String, dynamic>> chartData = [];
    final dateFormat = DateFormat('MMM dd');

    for (var date in dates) {
      final dateStr = DateFormat('yyyy-MM-dd').format(date);
      int count = recentEmails
          .where((email) => DateFormat('yyyy-MM-dd').format(email.dateSent) == dateStr)
          .length;

      chartData.add({
        'date': dateFormat.format(date),
        'count': count,
      });
    }

    return chartData;
  }
}
