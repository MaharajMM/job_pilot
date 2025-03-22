import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_pilot/data/models/sent_email_model.dart';
import 'package:job_pilot/data/service/email_template/email_template_db_service_pod.dart';

class HistoryTab extends ConsumerWidget {
  const HistoryTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sentEmails = ref.watch(emailTemplateDbProvider).getSentEmails();

    if (sentEmails.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.history,
              size: 64,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              'No email history yet',
              style: TextStyle(fontSize: 18, color: Colors.grey[600]),
            ),
            const SizedBox(height: 8),
            Text(
              'Send your first email to see it here',
              style: TextStyle(color: Colors.grey[500]),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: sentEmails.length,
      itemBuilder: (context, index) {
        // Sort emails by date (newest first)
        final sortedEmails = List<SentEmail>.from(sentEmails)
          ..sort((a, b) => b.dateSent.compareTo(a.dateSent));

        final email = sortedEmails[index];

        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.send,
                        color: Theme.of(context).colorScheme.primary,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            email.subject,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Sent: ${email.getFormattedDate()}',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (email.hasAttachment)
                      Tooltip(
                        message: 'Includes attachment',
                        child: Icon(
                          Icons.attachment,
                          color: Colors.grey[600],
                          size: 20,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Sent to ${email.recipients.length} recipient${email.recipients.length > 1 ? 's' : ''}',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[800],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: email.recipients.take(3).map((recipient) {
                              return Chip(
                                label: Text(
                                  recipient,
                                  style: const TextStyle(fontSize: 12),
                                ),
                                backgroundColor: Theme.of(context).colorScheme.surface,
                              );
                            }).toList() +
                            (email.recipients.length > 3
                                ? [
                                    Chip(
                                      label: Text(
                                        '+${email.recipients.length - 3} more',
                                        style: const TextStyle(fontSize: 12),
                                      ),
                                      backgroundColor:
                                          Theme.of(context).colorScheme.surfaceContainerHigh,
                                    ),
                                  ]
                                : []),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                ExpansionTile(
                  title: const Text('Email Content'),
                  initiallyExpanded: false,
                  tilePadding: const EdgeInsets.symmetric(horizontal: 8),
                  childrenPadding: const EdgeInsets.all(16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  children: [
                    Text(
                      email.body,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
