import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:job_pilot/const/colors/app_colors.dart';
import 'package:job_pilot/features/email_preview/view/widgets/preview_recipient_card.dart';
import 'package:job_pilot/shared/widget/buttons/app_primary_btn.dart';

class EmailPreviewSheet extends StatelessWidget {
  final List<String> recipients;
  final String subject;
  final String body;
  final String? attachmentName;
  final ScrollController scrollController;
  final VoidCallback onSend;

  const EmailPreviewSheet({
    super.key,
    required this.recipients,
    required this.subject,
    required this.body,
    this.attachmentName,
    required this.scrollController,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.grey200,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          )),
      child: ListView(
        controller: scrollController,
        padding: const EdgeInsets.all(16),
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Email Preview',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              GestureDetector(
                onTap: () => context.maybePop(),
                child: Icon(
                  size: 20,
                  Icons.cancel_outlined,
                  color: AppColors.kBlack,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          PreviewRecipientCard(
            title: 'Recipients',
            icon: Icons.people,
            children: [
              Text('${recipients.length} recipient${recipients.length > 1 ? 's' : ''}'),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: recipients
                        .take(5)
                        .map((email) => Chip(
                              label: Text(
                                email,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: AppColors.kwhite,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              backgroundColor: AppColors.kPrimaryBgColor,
                            ))
                        .toList() +
                    (recipients.length > 5
                        ? [
                            Chip(
                              label: Text(
                                '+${recipients.length - 5} more',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: AppColors.kwhite,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              backgroundColor: AppColors.kPrimaryBgColor,
                            ),
                          ]
                        : []),
              ),
            ],
          ),
          const SizedBox(height: 16),
          PreviewRecipientCard(
            title: 'Subject',
            icon: Icons.subject,
            children: [
              Text(subject),
            ],
          ),
          const SizedBox(height: 16),
          PreviewRecipientCard(
            title: 'Body',
            icon: Icons.description,
            children: [
              Text(body),
            ],
          ),
          const SizedBox(height: 16),
          if (attachmentName != null)
            PreviewRecipientCard(
              title: 'Attachment',
              icon: Icons.attach_file,
              children: [
                Row(
                  children: [
                    const Icon(Icons.insert_drive_file, size: 20),
                    const SizedBox(width: 8),
                    Expanded(child: Text(attachmentName!)),
                  ],
                ),
              ],
            ),
          const SizedBox(height: 32),
          PrimaryButton(
            labelText: 'Send to ${recipients.length} Recipient${recipients.length > 1 ? 's' : ''}',
            onPressed: onSend,
            isIcon: true,
            icon: const Icon(
              Icons.send,
              color: AppColors.kBlack,
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
