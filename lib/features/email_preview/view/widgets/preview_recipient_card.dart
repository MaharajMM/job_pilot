import 'package:flutter/material.dart';
import 'package:job_pilot/const/colors/app_colors.dart';
import 'package:job_pilot/shared/widget/custom_card.dart';

class PreviewRecipientCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<Widget> children;
  const PreviewRecipientCard({
    super.key,
    required this.title,
    required this.icon,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: AppColors.green800, size: 20),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.green800,
                ),
              ),
            ],
          ),
          const Divider(height: 24),
          ...children,
        ],
      ),
    );
  }
}
