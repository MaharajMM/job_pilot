import 'package:flutter/material.dart';
import 'package:job_pilot/const/colors/app_colors.dart';

class ProfileUserHeader extends StatelessWidget {
  final String? userName;
  final String? userEmail;
  const ProfileUserHeader({
    super.key,
    this.userName,
    this.userEmail,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          // Animated avatar
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.0, end: 1.0),
            duration: const Duration(milliseconds: 800),
            builder: (context, value, child) {
              return Transform.scale(
                scale: value,
                child: child,
              );
            },
            child: CircleAvatar(
              radius: 50,
              backgroundColor: AppColors.kPrimaryColor.withValues(alpha: 0.3),
              child: Text(
                userName != null && userName!.isNotEmpty
                    ? userName!.substring(0, 1).toUpperCase()
                    : '?',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            userName != null && userName!.isNotEmpty ? userName! : 'Your Name',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            userEmail != null && userEmail!.isNotEmpty ? userEmail! : 'your.email@example.com',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}
