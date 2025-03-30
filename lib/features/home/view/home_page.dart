import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:job_pilot/const/borders/app_borders.dart';
import 'package:job_pilot/const/colors/app_colors.dart';
import 'package:job_pilot/features/analytics/view/analytics_tab.dart';
import 'package:job_pilot/features/home/widgets/history_tab.dart';
import 'package:velocity_x/velocity_x.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return HomeView();
  }
}

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final String userName = "Raj";

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hi, $userName',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      Text(
                        'Good morning',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w400,
                            ),
                      ),
                    ],
                  ),
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: AppColors.kPrimaryColor,
                    child: Icon(
                      Icons.person_outline_sharp,
                      size: 30,
                    ),
                  )
                ],
              ),
            ),
            10.heightBox,
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
                Tab(text: 'Analytics').w(100),
                Tab(text: 'History').w(100),
              ],
            ),
            16.heightBox,
            Flexible(
              child: TabBarView(
                controller: _tabController,
                children: [
                  AnalyticsTab(),
                  HistoryTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
