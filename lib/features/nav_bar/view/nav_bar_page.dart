import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
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
        return Material(
          elevation: 10,
          shadowColor: AppColors.grey600, // Shadow color
          child: NavigationBarTheme(
            data: NavigationBarThemeData(
              indicatorColor: AppColors.kPrimaryColor,
              labelTextStyle: WidgetStateProperty.all(
                Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w400,
                    ),
              ),
            ),
            child: NavigationBar(
              elevation: 2,
              selectedIndex: tabsRouter.activeIndex,
              height: 65,
              backgroundColor: AppColors.kwhite,
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
                    color: AppColors.kPrimaryBgColor,
                  ),
                  label: 'Dashboard',
                ),
                NavigationDestination(
                  icon: Icon(
                    Icons.mark_email_unread_rounded,
                    size: 30,
                    color: AppColors.kPrimaryBgColor,
                  ),
                  label: 'Send Emails',
                ),
                NavigationDestination(
                  icon: Icon(
                    Icons.person,
                    size: 30,
                    color: AppColors.kPrimaryBgColor,
                  ),
                  label: 'Profile',
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
