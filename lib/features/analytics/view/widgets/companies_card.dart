import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_pilot/const/colors/app_colors.dart';
import 'package:job_pilot/features/home/controller/home_pod.dart';
import 'package:job_pilot/features/home/view/widget/company_list_sheet.dart';
import 'package:job_pilot/shared/widget/custom_card.dart';
import 'package:job_pilot/shared/widget/icon_card.dart';

class CompaniesCard extends ConsumerWidget {
  const CompaniesCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final companyData = ref.watch(companyApplicationCountsProvider);
    final sortedCompanies = companyData.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

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
                IconCard(icon: Icons.business),
                const SizedBox(width: 8),
                Text(
                  'Companies Applied To',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            sortedCompanies.isEmpty
                ? Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Center(
                      child: Text(
                        'No applications sent yet',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ),
                  )
                : ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: sortedCompanies.length > 5 ? 5 : sortedCompanies.length,
                    separatorBuilder: (context, index) => const Divider(),
                    itemBuilder: (context, index) {
                      final company = sortedCompanies[index];
                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: CircleAvatar(
                          backgroundColor: AppColors.kPrimaryColor.withValues(alpha: 0.2),
                          child: Text(
                            company.key.substring(0, 1).toUpperCase(),
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onSecondaryContainer,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        title: Text(
                          company.key,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(),
                        ),
                        trailing: Chip(
                          label: Text(
                            '${company.value} ${company.value == 1 ? 'application' : 'applications'}',
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.kwhite,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          backgroundColor: AppColors.kPrimaryBgColor,
                        ),
                      );
                    },
                  ),
            if (sortedCompanies.length > 5) ...[
              const Divider(),
              Center(
                child: TextButton.icon(
                  onPressed: () {
                    // Show all companies in a full page or modal
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                      ),
                      builder: (context) => DraggableScrollableSheet(
                        initialChildSize: 0.7,
                        maxChildSize: 0.9,
                        minChildSize: 0.5,
                        expand: false,
                        builder: (context, scrollController) {
                          return CompaniesListSheet(
                            companies: sortedCompanies,
                            scrollController: scrollController,
                          );
                        },
                      ),
                    );
                  },
                  icon: const Icon(Icons.visibility),
                  label: const Text('View All Companies'),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
