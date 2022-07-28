import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/config/constants/text_const.dart';

// class HomeAppBar extends StatelessWidget {
//   const HomeAppBar({Key? key, required this.tabController}) : super(key: key);

//   final TabController tabController;

//   @override
//   Widget build(BuildContext context) {
//     final ThemeData theme = Theme.of(context);

//     return AppBar(
//       title: const Text(
//         boardTitleText,
//       ),
//       actions: [
//         _calenderIcon(context),
//       ],
//       bottom: PreferredSize(
//         child: HomeTabBar(tabController: tabController),
//         preferredSize: Size(
//           double.infinity,
//           70.h,
//         ),
//       ),
//     );
//   }

//   Widget _calenderIcon(BuildContext context) {
//     return IconButton(
//       onPressed: () {},
//       icon: const Icon(
//         Icons.calendar_today,
//         color: Colors.black,
//       ),
//     );
//   }
// }

class HomeTabBar extends StatelessWidget {
  const HomeTabBar({
    Key? key,
    required this.tabController,
  }) : super(key: key);
  final TabController tabController;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border.symmetric(
            horizontal: BorderSide(
          color: Colors.black54,
          width: 1,
        )),
      ),
      child: TabBar(
        isScrollable: true,
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        physics: const BouncingScrollPhysics(),
        indicatorColor: Colors.black,
        indicatorSize: TabBarIndicatorSize.label,
        labelColor: Colors.black,
        unselectedLabelColor: Colors.black54,
        labelPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 20),
        controller: tabController,
        tabs: [
          _tabName('All'),
          _tabName('Completed'),
          _tabName('UnCompleted'),
          _tabName('Favorites'),
        ],
      ),
    );
  }

  Text _tabName(String name) {
    return Text(
      name,
      style: TextStyle(
        fontSize: 16.sp,
      ),
    );
  }
}
