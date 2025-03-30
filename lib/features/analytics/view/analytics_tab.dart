import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_pilot/features/analytics/view/widgets/chart_card.dart';
import 'package:job_pilot/features/analytics/view/widgets/companies_card.dart';
import 'package:job_pilot/features/analytics/view/widgets/stats_card.dart';
import 'package:job_pilot/features/home/controller/home_pod.dart';

class AnalyticsTab extends ConsumerStatefulWidget {
  const AnalyticsTab({super.key});

  @override
  ConsumerState<AnalyticsTab> createState() => _AnalyticsTabState();
}

class _AnalyticsTabState extends ConsumerState<AnalyticsTab> {
  // Sample data for chart
  @override
  Widget build(BuildContext context) {
    final chartData = ref.watch(weeklyChartDataProvider);
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Stats cards
          StatsCard(),
          const SizedBox(height: 16),

          // Weekly email chart
          ChartCard(chartData: chartData),
          const SizedBox(height: 16),

          // Companies applied to
          CompaniesCard(),
        ],
      ),
    );
  }
}
