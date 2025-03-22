import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:job_pilot/const/colors/app_colors.dart';
import 'package:job_pilot/core/router/router.gr.dart';

@RoutePage()
class NavBarPage extends StatelessWidget {
  const NavBarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      routes: const [
        HomeRoute(),
        EmailSenderRoute(),
        ProfileRoute(),
      ],
      homeIndex: 0,
      bottomNavigationBuilder: (context, tabsRouter) {
        return NavigationBarTheme(
          data: NavigationBarThemeData(
            indicatorColor: AppColors.kPrimaryColor,
            labelTextStyle: WidgetStateProperty.all(
              GoogleFonts.poppins(
                fontSize: 10,
                color: AppColors.grey100,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          child: NavigationBar(
            selectedIndex: tabsRouter.activeIndex,
            height: 55,
            backgroundColor: AppColors.kPrimaryBgColor,
            onDestinationSelected: (index) {
              if (index == 1) {
                // Navigate to login before accessing Bulk Email or Profile
                context.navigateTo(EmailSenderRoute());
              } else {
                tabsRouter.setActiveIndex(index);
              }
            },
            shadowColor: AppColors.green100,
            destinations: [
              NavigationDestination(
                icon: Icon(
                  Icons.space_dashboard_rounded,
                  size: 30,
                ),
                label: 'Dashboard',
              ),
              NavigationDestination(
                icon: Icon(Icons.send, size: 30),
                label: 'Send Emails',
              ),
              NavigationDestination(
                icon: Icon(Icons.person, size: 30),
                label: 'Profile',
              ),
            ],
          ),
        );
      },
    );
  }
}
