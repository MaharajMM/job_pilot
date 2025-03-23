import 'dart:math' as math;

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:job_pilot/const/colors/app_colors.dart';
import 'package:job_pilot/features/analytics/controller/analytics_service.dart';
import 'package:job_pilot/shared/widget/custom_card.dart';
import 'package:job_pilot/shared/widget/icon_card.dart';

class ChartCard extends StatelessWidget {
  final List<Map<String, dynamic>> chartData;
  const ChartCard({
    super.key,
    required this.chartData,
  });

  @override
  Widget build(BuildContext context) {
    double maxCount = 0;
    double maxY = 0;
    double interval = 0;
    if (chartData.isNotEmpty) {
      maxCount = chartData.map<double>((e) => e['count'].toDouble()).reduce(math.max);

// Calculate our nice values
      maxY = AnalyticsService().calculateNiceMaxY(maxCount, chartData);
      interval = AnalyticsService().calculateNiceInterval(maxY);
    }

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 1000),
      builder: (context, opacity, child) {
        return Opacity(
          opacity: opacity,
          child: TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.8, end: 1.0),
            duration: const Duration(milliseconds: 500),
            builder: (context, scale, child) {
              return Transform.scale(
                scale: scale,
                child: child,
              );
            },
            child: child,
          ),
        );
      },
      child: CustomCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconCard(icon: Icons.bar_chart_rounded),
                const SizedBox(width: 8),
                Text(
                  'Applications Last 7 Days',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 200,
              child: chartData.isEmpty
                  ? Center(
                      child: Text('No data to display', style: TextStyle(color: Colors.grey[600])),
                    )
                  : BarChart(
                      BarChartData(
                        alignment: BarChartAlignment.spaceAround,
                        minY: 0,
                        maxY: maxY,
                        // groupsSpace: 12,
                        barTouchData: BarTouchData(
                          enabled: true,
                          touchTooltipData: BarTouchTooltipData(
                            getTooltipItem: (group, groupIndex, rod, rodIndex) {
                              return BarTooltipItem(
                                '${chartData[groupIndex]['count']}',
                                const TextStyle(
                                    color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                              );
                            },
                          ),
                        ),
                        titlesData: FlTitlesData(
                          show: true,
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (value, meta) {
                                if (value.toInt() >= chartData.length || value.toInt() < 0) {
                                  return const SizedBox();
                                }
                                return Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Text(
                                    chartData[value.toInt()]['date'],
                                    style: const TextStyle(fontSize: 10),
                                  ),
                                );
                              },
                              reservedSize: 30,
                            ),
                          ),
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (value, meta) {
                                // if (value % 1 != 0) return const SizedBox();
                                // Only show labels at multiples of the interval
                                if (value % interval != 0) return const SizedBox();
                                // Don't show value greater than maxY
                                if (value > maxY) return const SizedBox();
                                return Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Text(
                                    value.toInt().toString(),
                                    style: const TextStyle(fontSize: 10),
                                  ),
                                );
                              },
                              reservedSize: 30,
                              interval: interval,
                            ),
                          ),
                          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        ),
                        gridData: FlGridData(
                          show: true,
                          drawVerticalLine: false,
                          horizontalInterval: interval,
                          getDrawingHorizontalLine: (value) {
                            return FlLine(
                              color: AppColors.grey800.withOpacity(0.2),
                              strokeWidth: 1,
                              dashArray: [5, 5],
                            );
                          },
                        ),
                        borderData: FlBorderData(show: false),
                        barGroups: List.generate(
                          chartData.length,
                          (index) => BarChartGroupData(
                            x: index,
                            barRods: [
                              BarChartRodData(
                                toY: chartData[index]['count'].toDouble(),
                                color: AppColors.kPrimaryColor,
                                width: 20,
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(6),
                                  topRight: Radius.circular(6),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      duration: const Duration(milliseconds: 800),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
