import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:job_pilot/const/colors/app_colors.dart';
import 'package:job_pilot/data/models/user_model.dart';
import 'package:job_pilot/data/service/user_profile/user_profile_db_service_pod.dart';
import 'package:job_pilot/features/bulk_email/view/widgets/section_title_card.dart';
import 'package:job_pilot/features/profile/const/profile_keys.dart';
import 'package:job_pilot/features/profile/view/widgets/profile_app_info_section.dart';
import 'package:job_pilot/features/profile/view/widgets/profile_user_header.dart';
import 'package:job_pilot/shared/widget/animations/tween_animation_builder.dart';
import 'package:job_pilot/shared/widget/buttons/app_primary_btn.dart';
import 'package:job_pilot/shared/widget/custom_card.dart';
import 'package:job_pilot/shared/widget/custom_text_formfield.dart';

class ProfileTab extends ConsumerStatefulWidget {
  const ProfileTab({super.key});

  @override
  ConsumerState<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends ConsumerState<ProfileTab> {
  final _profileFormKey = GlobalKey<FormBuilderState>();

  Future<void> _updateProfile() async {
    if (_profileFormKey.currentState?.validate() ?? false) {
      HapticFeedback.lightImpact();
      Feedback.forTap(context);
      final fields = _profileFormKey.currentState!.fields;
      final userEmail = fields[ProfileKeys.userEmail]?.value as dynamic;
      final userName = fields[ProfileKeys.userName]?.value as dynamic;

      final updatedProfile = UserProfile(
        primaryEmail: userEmail.trim(),
        name: userName.trim(),
      );

      await ref.read(userProfileDbProvider).saveUserProfile(userProfile: updatedProfile);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile updated successfully')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final userProfile = ref.watch(userProfileDbProvider).getUserProfile();
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              ProfileUserHeader(
                userName: userProfile?.name,
                userEmail: userProfile?.primaryEmail,
              ),
              const SizedBox(height: 24),
              TweenAnimation(
                child: CustomCard(
                  child: FormBuilder(
                    key: _profileFormKey,
                    initialValue: userProfile != null
                        ? {
                            ProfileKeys.userName: userProfile.name,
                            ProfileKeys.userEmail: userProfile.primaryEmail,
                          }
                        : {},
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SectionTitleCard(
                          title: 'Contact Information',
                          icon: Icons.contact_mail,
                        ),
                        const SizedBox(height: 16),
                        CustomTextFormField(
                          name: ProfileKeys.userEmail,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          labelText: 'Email',
                          prefixIcon: Icon(Icons.email, color: AppColors.grey800),
                          validator: FormBuilderValidators.compose(
                            [
                              FormBuilderValidators.required(),
                              FormBuilderValidators.email(),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        CustomTextFormField(
                          name: ProfileKeys.userName,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          labelText: 'Name',
                          prefixIcon: Icon(Icons.person, color: AppColors.grey800),
                          validator: FormBuilderValidators.compose(
                            [
                              FormBuilderValidators.required(),
                            ],
                          ),
                        ),
                        const SizedBox(height: 32),
                        PrimaryButton(
                          labelText: 'Save Profile',
                          onPressed: _updateProfile,
                          isIcon: true,
                          icon: const Icon(
                            Icons.save,
                            color: AppColors.kBlack,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              TweenAnimation(child: ProfileAppInfoSection()),
            ],
          ),
        );
      },
    );
  }
}
