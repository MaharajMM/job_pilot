import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:job_pilot/const/colors/app_colors.dart';
import 'package:job_pilot/core/router/router.gr.dart';
import 'package:job_pilot/features/email_onboard/const/email_onboard_keys.dart';
import 'package:job_pilot/features/email_onboard/controller/email_onboard_pod.dart';
import 'package:job_pilot/features/email_onboard/view/widgets/save_btn.dart';
import 'package:job_pilot/shared/widget/animations/slide_animation_builder.dart';
import 'package:job_pilot/shared/widget/attachment_selector_widget.dart';
import 'package:job_pilot/shared/widget/custom_text_formfield.dart';

@RoutePage()
class EmailOnboardPage extends StatelessWidget {
  const EmailOnboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return EmailOnboardView();
  }
}

class EmailOnboardView extends ConsumerStatefulWidget {
  const EmailOnboardView({super.key});

  @override
  ConsumerState<EmailOnboardView> createState() => _EmailOnboardViewState();
}

class _EmailOnboardViewState extends ConsumerState<EmailOnboardView> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  void dispose() {
    _formKey.currentState?.dispose();
    super.dispose();
  }

  Future<void> _saveAndContinue(BuildContext mContext) async {
    //   // Save user profile
    if (_formKey.currentState?.validate() ?? false) {
      HapticFeedback.lightImpact();
      Feedback.forTap(context);
      final fields = _formKey.currentState!.fields;
      final email = fields[EmailOnboardKeys.email]!.value as String;
      final name = fields[EmailOnboardKeys.name]!.value as String;
      final subject = fields[EmailOnboardKeys.subject]!.value as String;
      final emailBody = fields[EmailOnboardKeys.emailBody]!.value as String;
      final addEmailFile = fields[EmailOnboardKeys.attachedDoc]?.value as dynamic;

      ref.read(emailControllerProvider.notifier).saveEmailDetails(
            name: name,
            emailId: email,
            subject: subject,
            body: emailBody,
            attachment: addEmailFile,
            onSavedEmail: () {
              if (mContext.mounted) {
                mContext.router.replaceAll([HomeRoute()]);
              }
            },
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Welcome header with animation
                _buildHeader(),
                const SizedBox(height: 32),

                SlideAnimationBuilder(
                  delay: Durations.medium3,
                  child: FormBuilder(
                    key: _formKey,
                    initialValue: user != null
                        ? {
                            EmailOnboardKeys.email: user.email,
                          }
                        : {},
                    child: Column(
                      children: [
                        // Profile section
                        _buildSectionTitle('Your Profile'),
                        const SizedBox(height: 16),
                        CustomTextFormField(
                          name: EmailOnboardKeys.email,
                          labelText: 'Your Email Address',
                          // hintText: 'Enter your primary email',
                          prefixIcon: Icon(Icons.email_outlined),
                          validator: FormBuilderValidators.compose(
                            [
                              FormBuilderValidators.required(),
                              FormBuilderValidators.email(),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        CustomTextFormField(
                          name: EmailOnboardKeys.name,
                          labelText: 'Your Name',
                          // hintText: 'Enter your full name',
                          prefixIcon: Icon(Icons.person_outline),
                          validator: FormBuilderValidators.compose(
                            [
                              FormBuilderValidators.required(),
                            ],
                          ),
                        ),
                        const SizedBox(height: 32),

                        // Default email template section
                        _buildSectionTitle('Default Email Template'),
                        const SizedBox(height: 16),
                        CustomTextFormField(
                          name: EmailOnboardKeys.subject,
                          labelText: 'Default Subject',
                          hintText: 'E.g., Job Application for [Position]',
                          prefixIcon: Icon(Icons.subject),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a default subject';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        CustomTextFormField(
                          name: EmailOnboardKeys.emailBody,
                          labelText: 'Default Email Body',
                          hintText: 'Enter your default email content',
                          prefixIcon: Icon(Icons.description_outlined),
                          maxLine: 10,
                          minLine: 4,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter default email content';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),

                        // Attachment section
                        AttachmentSelectorWidget(
                          name: EmailOnboardKeys.attachedDoc,
                          formKey: _formKey,
                        ),

                        const SizedBox(height: 32),

                        // Submit button
                        EmailOnboardSaveButton(
                          onSubmit: () => _saveAndContinue(context),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Logo animation
        Center(
          child: TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.0, end: 1.0),
            duration: const Duration(milliseconds: 800),
            builder: (context, value, child) {
              return Transform.scale(
                scale: value,
                child: Icon(
                  Icons.mark_email_unread,
                  size: 80,
                  color: AppColors.kPrimaryColor,
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 24),
        // Welcome text with fade-in animation
        TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.0, end: 1.0),
          duration: const Duration(milliseconds: 1000),
          builder: (context, value, child) {
            return Opacity(
              opacity: value,
              child: child,
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome!',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                'Let\'s set up your job application email manager',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppColors.grey700,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.kPrimaryColor.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(
            title.contains('Profile') ? Icons.person : Icons.email,
          ),
          const SizedBox(width: 8),
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ],
      ),
    );
  }
}
