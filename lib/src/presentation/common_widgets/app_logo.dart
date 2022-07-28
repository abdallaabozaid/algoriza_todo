// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// import 'package:internship_tasks_06/config/constants/assets_const.dart';
// import 'package:internship_tasks_06/config/constants/colors_const.dart';

// class AppLogo extends StatelessWidget {
//   const AppLogo({
//     Key? key,
//     required this.width,
//     this.onlyTextLogo = false,
//     this.onlyImageLogo = false,
//   }) : super(key: key);

//   final double width;
//   final bool onlyTextLogo;
//   final bool onlyImageLogo;

//   @override
//   Widget build(BuildContext context) {
//     final ThemeData theme = Theme.of(context);
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           if (!onlyTextLogo) _shape(),
//           SizedBox(
//             height: 12.h,
//           ),
//           if (!onlyImageLogo) _text(theme),
//         ],
//       ),
//     );
//   }

//   Stack _shape() {
//     return Stack(
//       children: [
//         _logoOutlines(),
//         _corner(
//             rotation: -0.7,
//             transition: 4,
//             top: 0,
//             left: 0,
//             alignment: Alignment.topCenter),
//         _corner(
//             rotation: 0.7,
//             transition: 4,
//             top: 0,
//             right: 0,
//             alignment: Alignment.topCenter),
//         _corner(
//           rotation: 0.7,
//           transition: -4,
//           bottom: 0,
//           left: 0,
//           alignment: Alignment.bottomCenter,
//         ),
//         _corner(
//           rotation: -0.7,
//           transition: -4,
//           bottom: 0,
//           right: 0,
//           alignment: Alignment.bottomCenter,
//         ),
//       ],
//     );
//   }

//   Container _logoOutlines() {
//     return Container(
//       width: width.w,
//       height: width.w,
//       decoration: BoxDecoration(
//         shape: BoxShape.rectangle,
//         color: Colors.transparent,
//         border: Border.all(
//           width: 5.w,
//           color: AppColors.logoPrimaryColor,
//         ),
//       ),
//       child: UnconstrainedBox(
//         child: Container(
//           alignment: Alignment.center,
//           width: width * 0.78.w,
//           height: width * 0.78.w,
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             color: Colors.transparent,
//             border: Border.all(
//               width: 5.w,
//               color: AppColors.logoPrimaryColor,
//             ),
//           ),
//           child: Image.asset(
//             AppAssets.logoBoxAsset,
//             width: width * 0.38.w,
//             height: width * 0.38.w,
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _corner({
//     required double transition,
//     required double rotation,
//     required Alignment alignment,
//     double? left,
//     double? right,
//     double? bottom,
//     double? top,
//   }) {
//     return Positioned(
//       left: left,
//       right: right,
//       bottom: bottom,
//       top: top,
//       child: Transform.translate(
//         offset: Offset(0, transition),
//         child: Transform(
//           alignment: alignment,
//           transform: Matrix4.rotationZ(rotation),
//           // angle: 100,
//           child: Container(
//             width: (width * 0.03).w,
//             height: (width * 0.43).h,
//             decoration: BoxDecoration(
//               color: AppColors.logoPrimaryColor,
//               borderRadius: BorderRadius.circular(
//                 20.r,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _text(ThemeData theme) {
//     return Text(
//       'Shipper',
//       style: TextStyle(
//         fontSize: 35.sp,
//         color: theme.colorScheme.onPrimary,
//       ),
//     );
//   }
// }
