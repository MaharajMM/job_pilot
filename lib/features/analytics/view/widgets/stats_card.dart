import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_pilot/const/colors/app_colors.dart';
import 'package:job_pilot/features/home/controller/home_pod.dart';
import 'package:job_pilot/shared/widget/custom_card.dart';
import 'package:job_pilot/shared/widget/icon_card.dart';
import 'package:velocity_x/velocity_x.dart';

class StatsCard extends ConsumerWidget {
  const StatsCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        _buildStatCard(
          context,
          'Total Applications',
          ref.watch(companyApplicationCountsProvider).keys.length.toString(),
          Icons.send,
        ),
        const SizedBox(width: 16),
        _buildStatCard(
          context,
          'Companies',
          ref.watch(uniqueCompanyCountProvider).toString(),
          Icons.business,
        ),
      ],
    );
  }

  Widget _buildStatCard(BuildContext context, String title, String value, IconData icon) {
    return Expanded(
      child: TweenAnimationBuilder<double>(
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
              IconCard(icon: icon),
              const SizedBox(height: 16),
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.grey600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ).h(150),
      ),
    );
  }
}
