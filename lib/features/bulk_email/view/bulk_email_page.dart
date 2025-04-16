import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_pilot/const/colors/app_colors.dart';
import 'package:job_pilot/data/service/email_template/email_template_db_service_pod.dart';
import 'package:job_pilot/features/bulk_email/const/bulk_email_keys.dart';
import 'package:job_pilot/features/bulk_email/view/widgets/section_title_card.dart';
import 'package:job_pilot/features/email_preview/view/email_preview_sheet.dart';
import 'package:job_pilot/shared/utility/utilities.dart';
import 'package:job_pilot/shared/widget/attachment_selector_widget.dart';
import 'package:job_pilot/shared/widget/buttons/app_primary_btn.dart';
import 'package:job_pilot/shared/widget/custom_card.dart';
import 'package:job_pilot/shared/widget/custom_text_formfield.dart';

@RoutePage()
class BulkEmailPage extends StatelessWidget {
  const BulkEmailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BulkEmailView();
  }
}

class BulkEmailView extends ConsumerStatefulWidget {
  const BulkEmailView({super.key});

  @override
  ConsumerState<BulkEmailView> createState() => _BulkEmailViewState();
}

class _BulkEmailViewState extends ConsumerState<BulkEmailView> {
  final _bulkEmailFormKey = GlobalKey<FormBuilderState>();

  // String? _attachmentName;

  @override
  void dispose() {
    _bulkEmailFormKey.currentState?.dispose();
    super.dispose();
  }

  List<String> _parseRecipients(String recipientEmail) {
    // Split by newline, comma, or semicolon and trim each email
    final emailList = recipientEmail
        .split(RegExp(r'[,;\n]'))
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();

    return emailList;
  }

  Future<void> _showPreviewBottomSheet() async {
    if (_bulkEmailFormKey.currentState?.validate() ?? false) {
      HapticFeedback.lightImpact();
      Feedback.forTap(context);
      final fields = _bulkEmailFormKey.currentState!.fields;
      final recipientEmail = fields[BulkEmailKeys.recipientEmail]?.value as String;
      final subject = fields[BulkEmailKeys.subject]?.value as String;
      final emailBody = fields[BulkEmailKeys.emailBody]?.value as String;
      final attachedFile = fields[BulkEmailKeys.attachment]?.value as dynamic;
      final recipients = _parseRecipients(recipientEmail);
      if (recipients.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please enter at least one recipient email')),
        );
        return;
      }
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        builder: (context) => DraggableScrollableSheet(
          initialChildSize: 0.75,
          maxChildSize: 0.9,
          minChildSize: 0.5,
          expand: false,
          builder: (context, scrollController) {
            return EmailPreviewSheet(
              recipients: recipients,
              subject: subject,
              body: emailBody,
              attachmentFile: attachedFile,
              attachmentName: attachedFile.path.split('/').last,
              scrollController: scrollController,
              onSend: () async {},
            );
          },
        ),
      );
    } else {
      Utilities.flushBarErrorMessage(message: 'Please fill all the fields.', context: context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Send Bulk Email'),
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final template = ref.watch(emailTemplateDbProvider).getEmailTemplate();

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: FormBuilder(
              key: _bulkEmailFormKey,
              initialValue: template != null
                  ? template.attachmentPath != null
                      ? {
                          BulkEmailKeys.subject: template.subject,
                          BulkEmailKeys.emailBody: template.body,
                          BulkEmailKeys.attachment: File(template.attachmentPath!),
                        }
                      : {
                          BulkEmailKeys.subject: template.subject,
                          BulkEmailKeys.emailBody: template.body,
                        }
                  : {},
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SectionTitleCard(title: 'Recipients'),
                  const SizedBox(height: 12),
                  _buildRecipientsField(),
                  const SizedBox(height: 24),
                  SectionTitleCard(title: 'Email Content'),
                  const SizedBox(height: 12),
                  CustomTextFormField(
                    name: BulkEmailKeys.subject,
                    labelText: 'Subject',
                    prefixIcon: const Icon(Icons.subject),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a subject';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  CustomTextFormField(
                    name: BulkEmailKeys.emailBody,
                    labelText: 'Email Body',
                    isAlignWithHint: true,
                    maxLine: 10,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter email content';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  AttachmentSelectorWidget(
                    formKey: _bulkEmailFormKey,
                    name: BulkEmailKeys.attachment,
                  ),
                  const SizedBox(height: 24),
                  PrimaryButton(
                    isIcon: true,
                    labelText: 'Preview & Send',
                    onPressed: _showPreviewBottomSheet,
                    icon: const Icon(
                      Icons.visibility,
                      color: AppColors.kBlack,
                    ),
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildRecipientsField() {
    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Paste multiple email addresses below (separated by commas, semicolons, or new lines)',
            style: TextStyle(color: Colors.grey[700], fontSize: 14),
          ),
          const SizedBox(height: 12),
          CustomTextFormField(
            name: BulkEmailKeys.recipientEmail,
            hintText: 'e.g. john@example.com, jane@example.com',
            maxLine: 5,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter at least one email address';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
