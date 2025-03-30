import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_pilot/const/colors/app_colors.dart';
import 'package:job_pilot/data/models/email_template_model.dart';
import 'package:job_pilot/data/service/email_template/email_template_db_service_pod.dart';
import 'package:job_pilot/features/bulk_email/view/widgets/section_title_card.dart';
import 'package:job_pilot/features/profile/const/profile_keys.dart';
import 'package:job_pilot/shared/widget/attachment_selector_widget.dart';
import 'package:job_pilot/shared/widget/buttons/app_primary_btn.dart';
import 'package:job_pilot/shared/widget/custom_text_formfield.dart';
import 'package:velocity_x/velocity_x.dart';

class EmailTemplateTab extends ConsumerStatefulWidget {
  const EmailTemplateTab({super.key});

  @override
  ConsumerState<EmailTemplateTab> createState() => _EmailTemplateTabState();
}

class _EmailTemplateTabState extends ConsumerState<EmailTemplateTab> {
  final _emailTemplateFormKey = GlobalKey<FormBuilderState>();

  Future<void> _updateEmailTemplate() async {
    if (_emailTemplateFormKey.currentState?.validate() ?? false) {
      HapticFeedback.lightImpact();
      Feedback.forTap(context);
      final fields = _emailTemplateFormKey.currentState!.fields;
      final subject = fields[ProfileKeys.subject]?.value as dynamic;
      final body = fields[ProfileKeys.emailBody]?.value as dynamic;
      final attachment = fields[ProfileKeys.attachment]?.value as dynamic;

      final updatedTemplate = EmailTemplateModel(
        subject: subject.trim(),
        body: body.trim(),
        attachmentPath: attachment,
      );

      await ref.read(emailTemplateDbProvider).saveEmailTemplate(emailTemplate: updatedTemplate);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Email template updated successfully')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final savedEmailTemplate = ref.watch(emailTemplateDbProvider).getEmailTemplate();
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: FormBuilder(
            key: _emailTemplateFormKey,
            initialValue: savedEmailTemplate != null
                ? {
                    ProfileKeys.subject: savedEmailTemplate.subject,
                    ProfileKeys.emailBody: savedEmailTemplate.body,
                  }
                : {},
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SectionTitleCard(
                  title: 'Default Email Subject',
                  icon: Icons.email_outlined,
                ),
                const SizedBox(height: 16),
                CustomTextFormField(
                  name: ProfileKeys.subject,
                  labelText: 'Subject',
                  prefixIcon: const Icon(Icons.subject),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a default subject';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                SectionTitleCard(
                  title: 'Default Email Body',
                  icon: Icons.description,
                ),
                const SizedBox(height: 16),
                CustomTextFormField(
                  name: ProfileKeys.emailBody,
                  labelText: 'Email Content',
                  isAlignWithHint: true,
                  maxLine: 10,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter defualt email content';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                SectionTitleCard(
                  title: 'Default Attachment',
                  icon: Icons.attach_file,
                ),
                const SizedBox(height: 16),
                AttachmentSelectorWidget(),
                const SizedBox(height: 32),
                PrimaryButton(
                  labelText: 'Save Template',
                  onPressed: _updateEmailTemplate,
                  isIcon: true,
                  icon: const Icon(
                    Icons.save,
                    color: AppColors.kBlack,
                  ),
                ),
                50.heightBox,
              ],
            ),
          ),
        );
      },
    );
  }
}
