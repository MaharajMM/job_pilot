import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_pilot/const/colors/app_colors.dart';
import 'package:job_pilot/data/models/sent_email_model.dart';
import 'package:job_pilot/data/service/email_template/email_template_db_service_pod.dart';
import 'package:job_pilot/features/email_preview/view/widgets/preview_recipient_card.dart';
import 'package:job_pilot/features/email_sender/auth_api.dart';
import 'package:job_pilot/shared/utility/utilities.dart';
import 'package:job_pilot/shared/widget/buttons/app_primary_btn.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

class EmailPreviewSheet extends ConsumerStatefulWidget {
  final List<String> recipients;
  final String subject;
  final String body;
  final String? attachmentName;
  final File? attachmentFile;
  final ScrollController scrollController;
  final VoidCallback onSend;

  const EmailPreviewSheet({
    super.key,
    required this.recipients,
    required this.subject,
    required this.body,
    this.attachmentName,
    this.attachmentFile,
    required this.scrollController,
    required this.onSend,
  });

  @override
  ConsumerState<EmailPreviewSheet> createState() => _EmailPreviewSheetState();
}

class _EmailPreviewSheetState extends ConsumerState<EmailPreviewSheet> {
  Future<void> _sendEmail({
    required List<String> recipients,
    required String subject,
    required String body,
    String? attachmentName,
    required BuildContext mcontext,
  }) async {
    final user = await GoogleAuthApi.signIn();
    if (user == null) return;
    final email = user.email;
    final auth = await user.authentication;
    final token = auth.accessToken!;

    final smtpServer = gmailSaslXoauth2(email, token);

    List<String> emails = recipients;

    final message = Message()
      ..from = Address(email, user.displayName)
      ..recipients.addAll(emails)
      ..subject = subject
      ..text = body;

    // if (widget.attachmentFile != null) {
    //   final file = widget.attachmentFile;
    //   if (await file!.exists()) {
    //     message.attachments.add(FileAttachment(file));
    //   } else {
    //     if (mcontext.mounted) {
    //       Utilities.flushBarErrorMessage(
    //           message: 'Attachment file not found at path: $attachmentName', context: mcontext);
    //     }
    //   }
    // }

    try {
      await send(message, smtpServer);
      if (mcontext.mounted) {
        Utilities.flushBarSuccessMessage(message: "Email Sent Successfully!", context: mcontext);
      }
      final sentEmail = SentEmail(
        recipients: recipients,
        subject: subject,
        body: body,
        dateSent: DateTime.now(),
        hasAttachment: attachmentName != null,
        attachmentPath: attachmentName,
      );
      await ref.read(emailTemplateDbProvider).saveSentEmails(email: sentEmail);
      if (mcontext.mounted) {
        mcontext.router.canPop();
      }
    } catch (e) {
      if (mcontext.mounted) {
        Utilities.flushBarErrorMessage(
            message: "Failed to send email: ${e.toString()}", context: mcontext);
      }
    }
  }

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
        controller: widget.scrollController,
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
              Text(
                  '${widget.recipients.length} recipient${widget.recipients.length > 1 ? 's' : ''}'),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: widget.recipients
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
                    (widget.recipients.length > 5
                        ? [
                            Chip(
                              label: Text(
                                '+${widget.recipients.length - 5} more',
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
              Text(widget.subject),
            ],
          ),
          const SizedBox(height: 16),
          PreviewRecipientCard(
            title: 'Body',
            icon: Icons.description,
            children: [
              Text(widget.body),
            ],
          ),
          const SizedBox(height: 16),
          if (widget.attachmentName != null)
            PreviewRecipientCard(
              title: 'Attachment',
              icon: Icons.attach_file,
              children: [
                Row(
                  children: [
                    const Icon(Icons.insert_drive_file, size: 20),
                    const SizedBox(width: 8),
                    Expanded(child: Text(widget.attachmentName!)),
                  ],
                ),
              ],
            ),
          const SizedBox(height: 32),
          PrimaryButton(
            labelText:
                'Send to ${widget.recipients.length} Recipient${widget.recipients.length > 1 ? 's' : ''}',
            onPressed: () {
              _sendEmail(
                recipients: widget.recipients,
                subject: widget.subject,
                body: widget.body,
                attachmentName: widget.attachmentName,
                mcontext: context,
              );
            },
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
