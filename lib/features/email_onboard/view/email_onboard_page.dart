import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:job_pilot/const/colors/app_colors.dart';
import 'package:job_pilot/core/router/router.gr.dart';
import 'package:job_pilot/core/router/router_pod.dart';
import 'package:job_pilot/features/email_onboard/const/email_onboard_keys.dart';
import 'package:job_pilot/features/email_onboard/controller/email_onboard_pod.dart';
import 'package:job_pilot/features/email_onboard/view/widgets/save_btn.dart';
import 'package:job_pilot/shared/utility/utilities.dart';
import 'package:job_pilot/shared/widget/animations/slide_animation_builder.dart';
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
  String? _attachmentPath;
  String? _attachmentName;
  final bool _isLoading = false;

  @override
  void dispose() {
    _formKey.currentState?.dispose();
    super.dispose();
  }

  Future<void> _selectAttachment({
    required BuildContext mcontext,
    required FormFieldState<File> field,
  }) async {
    final result = await FilePicker.platform.pickFiles();

    if (result != null) {
      var pickedFile = result.files.first;
      setState(() {
        _attachmentPath = pickedFile.path;
        _attachmentName = pickedFile.name;
      });
      field.didChange(File(pickedFile.path!));
    } else {
      if (mcontext.mounted) {
        Utilities.flushBarErrorMessage(
          message: 'Please pick any file correctly',
          context: mcontext,
        );
      }
    }
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
      final addFoodImageFile = fields[EmailOnboardKeys.attachedDoc]!.value as File;

      ref.read(emailControllerProvider.notifier).saveEmailDetails(
            name: name,
            emailId: email,
            subject: subject,
            body: emailBody,
            attachment: addFoodImageFile,
            onSavedEmail: () {
              if (mContext.mounted) {
                ref.read(autorouterProvider).replace(HomeRoute());
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
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
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
                              _buildAttachmentSelector(EmailOnboardKeys.attachedDoc),

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

  Widget _buildAttachmentSelector(String name) {
    return FormBuilderField<File>(
        name: name,
        builder: (field) {
          return Container(
            // elevation: 2,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: AppColors.kPrimaryColor.withValues(alpha: 0.3),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.attach_file,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Default Attachment',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Add a resume or portfolio to attach to your emails',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.grey700,
                        ),
                  ),
                  const SizedBox(height: 16),
                  if (_attachmentPath != null) ...[
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: AppColors.kPrimaryBgColor.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.insert_drive_file, size: 20),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              maxLines: 3,
                              _attachmentName ?? 'Selected file',
                              style: Theme.of(context).textTheme.bodyMedium,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(width: 4),
                          GestureDetector(
                            child: const Icon(Icons.close, size: 20),
                            onTap: () {
                              setState(() {
                                _attachmentPath = null;
                                _attachmentName = null;
                              });
                              field.reset();
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                  ElevatedButton.icon(
                    onPressed: () {
                      _selectAttachment(field: field, mcontext: context);
                    },
                    icon: const Icon(Icons.upload_file),
                    label: Text(_attachmentPath == null ? 'Select File' : 'Change File'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.kPrimaryBgColor,
                      foregroundColor: AppColors.kPrimaryColor,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  // Widget _buildSubmitButton() {
  //   return SizedBox(
  //     width: double.infinity,
  //     height: 55,
  //     child: ElevatedButton(
  //       onPressed: _saveAndContinue,
  //       style: ElevatedButton.styleFrom(
  //         backgroundColor: Theme.of(context).colorScheme.primary,
  //         foregroundColor: Theme.of(context).colorScheme.onPrimary,
  //       ),
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           const Text(
  //             'Save & Continue',
  //             style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
  //           ),
  //           const SizedBox(width: 8),
  //           TweenAnimationBuilder<double>(
  //             tween: Tween(begin: 0.0, end: 1.0),
  //             duration: const Duration(milliseconds: 500),
  //             builder: (context, value, child) {
  //               return Transform.translate(
  //                 offset: Offset(8.0 * value, 0),
  //                 child: Opacity(opacity: value, child: child),
  //               );
  //             },
  //             child: const Icon(Icons.arrow_forward),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
