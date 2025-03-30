import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:job_pilot/const/borders/app_borders.dart';
import 'package:job_pilot/const/colors/app_colors.dart';
import 'package:job_pilot/features/profile/view/tabs/email_template_tab.dart';
import 'package:job_pilot/features/profile/view/tabs/profile_tab.dart';
import 'package:velocity_x/velocity_x.dart';

@RoutePage()
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ProfileView();
  }
}

class ProfileView extends ConsumerStatefulWidget {
  const ProfileView({super.key});

  @override
  ConsumerState<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends ConsumerState<ProfileView> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    // _loadUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Profile & Settings'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            TabBar(
              controller: _tabController,
              indicator: BoxDecoration(
                color: AppColors.kPrimaryColor,
                borderRadius: AppBorder.kHalfMiddleCurve,
              ),
              padding: EdgeInsets.symmetric(horizontal: 20),
              splashFactory: NoSplash.splashFactory,
              overlayColor: WidgetStateProperty.all(Colors.transparent),
              tabAlignment: TabAlignment.start,
              isScrollable: true,
              labelPadding: EdgeInsets.only(right: 20),
              dividerColor: Colors.transparent,
              indicatorSize: TabBarIndicatorSize.label,
              unselectedLabelColor: AppColors.grey800,
              labelStyle: GoogleFonts.poppins(
                color: AppColors.kBlack,
                fontWeight: FontWeight.w600,
              ),
              tabs: [
                Tab(text: 'Profile').w(100),
                Tab(text: 'Email Template').w(150),
              ],
            ),
            16.heightBox,
            Flexible(
              child: TabBarView(
                controller: _tabController,
                children: [
                  ProfileTab(),
                  EmailTemplateTab(),
                ],
              ),
            ),
          ],
        ).pOnly(top: 20),
      ),
    );
  }
}
