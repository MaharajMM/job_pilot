import 'package:flutter/widgets.dart';
import 'package:job_pilot/const/colors/app_colors.dart';

class IconCard extends StatelessWidget {
  final IconData icon;
  const IconCard({
    super.key,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.kPrimaryColor.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(
        icon,
        color: AppColors.kPrimaryBgColor,
        size: 20,
      ),
    );
  }
}
