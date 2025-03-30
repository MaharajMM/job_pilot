import 'package:flutter/material.dart';
import 'package:job_pilot/features/bulk_email/view/widgets/section_title_card.dart';
import 'package:job_pilot/shared/widget/custom_card.dart';

class ProfileAppInfoSection extends StatelessWidget {
  const ProfileAppInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionTitleCard(title: 'About This App'),
          const SizedBox(height: 16),
          const ListTile(
            leading: Icon(Icons.info_outline),
            title: Text('App Version'),
            subtitle: Text('1.0.0'),
            contentPadding: EdgeInsets.zero,
          ),
          const Divider(),
          const ListTile(
            leading: Icon(Icons.security),
            title: Text('Privacy Policy'),
            subtitle: Text('All data is stored locally on your device'),
            contentPadding: EdgeInsets.zero,
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.delete_outline),
            title: const Text('Reset All Data'),
            subtitle: const Text('Clear all saved settings and history'),
            contentPadding: EdgeInsets.zero,
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Reset All Data?'),
                  content: const Text(
                    'This will delete all your email history and settings. This action cannot be undone.',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        // TODO: Implement data reset
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('All data has been reset')),
                        );
                      },
                      child: const Text('Reset', style: TextStyle(color: Colors.red)),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
