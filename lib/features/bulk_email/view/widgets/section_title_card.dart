import 'package:flutter/material.dart';
import 'package:job_pilot/const/colors/app_colors.dart';

class SectionTitleCard extends StatelessWidget {
  final String title;
  const SectionTitleCard({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.kPrimaryColor.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(
            title == 'Recipients'
                ? Icons.people
                : title == 'Email Content'
                    ? Icons.email
                    : Icons.attach_file,
            color: AppColors.green800,
          ),
          const SizedBox(width: 8),
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.green800,
                ),
          ),
        ],
      ),
    );
  }
}
