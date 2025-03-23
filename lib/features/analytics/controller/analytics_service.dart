import 'dart:math' as math;

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
    if (emails.isEmpty) return [];
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

// Calculate a nice rounded maxY value based on the max count
  double calculateNiceMaxY(double maxCount, List<Map<String, dynamic>> chartData) {
    if (maxCount <= 5) return 5; // Minimum maxY value

    // Get the magnitude (10^n where n is the number of digits - 1)
    int numDigits = maxCount.ceil().toString().length;
    double magnitude = math.pow(10, numDigits - 1).toDouble();
    // For smaller numbers (< 100), use finer granularity
    if (maxCount < 100) {
      // For numbers under 20, round to next 5
      if (maxCount < 20) {
        return ((maxCount / 5).ceil() * 5).toDouble();
      }
      // For numbers 20-100, round to next 10
      return ((maxCount / 10).ceil() * 10).toDouble();
    }

    // For larger numbers, round to next multiple of magnitude/5, magnitude/2, or magnitude
    if (maxCount < magnitude * 2) {
      return ((maxCount / (magnitude / 5)).ceil() * (magnitude / 5)).toDouble();
    } else if (maxCount < magnitude * 5) {
      return ((maxCount / (magnitude / 2)).ceil() * (magnitude / 2)).toDouble();
    } else {
      return ((maxCount / magnitude).ceil() * magnitude).toDouble();
    }
  }

// Calculate nice intervals based on the maxY
  double calculateNiceInterval(double maxY) {
    // Target 5-7 intervals on the y-axis
    int minIntervals = 4;
    int maxIntervals = 6;

    // For small values, use predefined intervals
    if (maxY <= 5) return 1;
    if (maxY <= 10) return 2;
    if (maxY <= 15) return 3;
    if (maxY <= 20) return 4;
    if (maxY <= 30) return 5;
    if (maxY <= 50) return 10;
    if (maxY <= 60) return 10;
    if (maxY <= 100) return 20;

    // Find a nice interval that divides maxY into roughly targetIntervals parts
    double rawInterval = maxY / minIntervals;

    // Round to a nice number
    int magnitudeExp = math.log(rawInterval) ~/ math.log(10);
    double magnitude = math.pow(10, magnitudeExp).toDouble();

    // Standard nice intervals as multipliers: 1, 2, 5
    List<double> niceIntervals = [1, 2, 5];
// Determine the best interval by checking how many divisions it creates
    for (double multiplier in niceIntervals) {
      double candidate = multiplier * magnitude;
      int divisions = (maxY / candidate).ceil();

      // Check if this gives us a good number of intervals
      if (divisions >= minIntervals && divisions <= maxIntervals) {
        return candidate;
      }
    }

    // Check the next magnitude up
    for (double multiplier in niceIntervals) {
      double candidate = multiplier * magnitude * 10;
      int divisions = (maxY / candidate).ceil();

      if (divisions >= minIntervals && divisions <= maxIntervals) {
        return candidate;
      }
    }

    // Fallback to a reasonable default
    return magnitude * 10;
  }
}
