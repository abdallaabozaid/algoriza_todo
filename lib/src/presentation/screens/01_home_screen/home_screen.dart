import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/config/constants/route_const.dart';
import 'package:todo_app/config/constants/text_const.dart';
import 'package:todo_app/src/infrastructure/02_notification/local/notification_api.dart';
import 'package:todo_app/src/presentation/common_widgets/buttons/primary_button.dart';
import 'package:todo_app/src/presentation/common_widgets/spacers/vertical_spacer.dart';
import 'package:todo_app/src/presentation/screens/00_common_widgets/app_bar.dart';
import 'package:todo_app/src/presentation/screens/01_home_screen/widgets/tab_bar.dart';
import 'package:todo_app/src/presentation/screens/01_home_screen/widgets/home_tab_builder.dart';

import '../../../infrastructure/01_tasks/local/tasks_database.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TasksDatabase.instance.delete(1);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 160.h),
        child: CommonAppBar(
          titleText: boardTitleText,
          borderSideWidth: 0,
          actions: [
            _calenderIcon(context),
          ],
          tabBarWidget: HomeTabBar(tabController: _tabController),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: TabBarView(
              controller: _tabController,
              physics: const BouncingScrollPhysics(),
              children: [
                HomeTabBuilder.allTasks(),
                HomeTabBuilder.completedTasks(),
                HomeTabBuilder.unCompletedTasks(),
                HomeTabBuilder.favoriteTasks(),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 28.w),
            child: PrimaryButton(
              onPressed: () => navigateToAddTaskScreen(),
              label: addTaskText,
            ),
          ),
          VerticalSpacer(height: 18.h),
        ],
      ),
    );
  }

  Widget _calenderIcon(BuildContext context) {
    return IconButton(
      onPressed: () => Navigator.pushNamed(context, scheduleScreen),
      icon: const Icon(
        Icons.calendar_today,
        color: Colors.black,
      ),
    );
  }

  void navigateToAddTaskScreen() {
    Navigator.pushNamed(context, addTaskScreen);
  }
}
